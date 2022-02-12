//
//  HYMenu.swift
//  HYMenu
//
//  Created by HENRY on 2022/2/8.
//
import UIKit
public class HYMenuViewController :UIViewController{
    
    var menuViewControllerLeadingConstraint :NSLayoutConstraint!
    
    var menuViewControllerWidthConstraint : NSLayoutConstraint!
    
    var menuViewController = UIViewController()
    
    var contentViewController = UIViewController()
    
    public var menuWidth = 150.0{
        didSet{
            menuViewControllerWidthConstraint.constant = menuWidth
            menuViewControllerLeadingConstraint.constant = -menuWidth
        }
    }
    
    public private(set) var isOpen :Bool = false
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        
    }
    func setup(){
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        edgeGesture.edges = .left
        view.addGestureRecognizer(edgeGesture)
//        addMenuViewController()
        menuViewControllerLeadingConstraint = menuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -menuWidth)
        menuViewControllerWidthConstraint = menuViewController.view.widthAnchor.constraint(equalToConstant: menuWidth)
    }
    public func setupMenuViewController(menuViewController:UIViewController){
        self.menuViewController = menuViewController
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        menuViewController.view.addGestureRecognizer(panGesture)
    }
    
    
    public func setupContentViewController(contentViewController:UIViewController){
        self.contentViewController = contentViewController
        addChild(self.contentViewController)
        view.addSubview(self.contentViewController.view)
        self.contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let contentleading = self.contentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let contenttrailing = self.contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let contentbottom = self.contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let contenttop = self.contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        view.addConstraints([contenttop,contentbottom,contentleading,contenttrailing])
        
    }
    
    func addMenuViewController(){
        if view.subviews.contains(menuViewController.view){
            return
        }
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
        setupMenuViewControllerLayout()
    }
    func setupMenuViewControllerLayout(){
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        menuViewControllerLeadingConstraint = menuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -menuWidth)
        let bottom = menuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let top = menuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        
        menuViewControllerWidthConstraint = menuViewController.view.widthAnchor.constraint(equalToConstant: menuWidth)
        view.addConstraints([menuViewControllerLeadingConstraint,bottom,top,menuViewControllerWidthConstraint])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func slideMenu(open:Bool){
        self.isOpen = open
        if open{
            addMenuViewController()
            UIView.animate(withDuration: 0.3) {
                self.menuViewControllerLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            } completion: { complete in
                
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.menuViewControllerLeadingConstraint.constant = -self.menuWidth
                self.view.layoutIfNeeded()
            }completion: { complete in
                self.menuViewController.view.removeFromSuperview()
                self.menuViewController.willMove(toParent: nil)
                self.menuViewController.removeFromParent()
            }
        }
    }
    @objc func handleGesture(gesture: UIPanGestureRecognizer){
        addMenuViewController()
        let menuView = gesture.view
        let transaltion = gesture.translation(in: menuView)
        let x = menuViewControllerLeadingConstraint.constant + transaltion.x
        switch gesture.state{
            
        case .changed:
            if x > 0 {
                break
            }
            else{
                menuViewControllerLeadingConstraint.constant += transaltion.x
            }
            gesture.setTranslation(CGPoint.zero, in: menuView)
        case .ended:
            slideMenu(open: menuViewControllerLeadingConstraint.constant > -menuWidth / 2)
        default:break
        }
    }
}
