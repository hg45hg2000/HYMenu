//
//  HYMenu.swift
//  HYMenu
//
//  Created by HENRY on 2022/2/8.
//
import UIKit
public protocol HYMenuViewControllerDelegate :NSObjectProtocol {
    func HYMenuViewControllerMenuDid(open:Bool ,edges:SlideSide)
}

public class HYMenuViewController :UIViewController{
    
    var leftViewLeadingConstraint :NSLayoutConstraint!
    
    var leftViewControllerWidthConstraint : NSLayoutConstraint!
    
    var rightViewLeadingConstraint :NSLayoutConstraint!
    
    var rightViewControllerWidthConstraint : NSLayoutConstraint!
    
    var leftViewController : UIViewController? = nil
    
    var centerViewController : UIViewController? = nil
    
    var rightViewController : UIViewController? = nil
    
    public weak var delegate :HYMenuViewControllerDelegate?
    
    let mannger = HYMenuMannger()
    
    public static let shared = HYMenuViewController()
    
    public var leftWidth : CGFloat = 150.0{
        didSet{
            leftViewControllerWidthConstraint.constant = leftWidth
            leftViewLeadingConstraint.constant = -leftWidth
        }
    }
    public var rightWidth : CGFloat = 150.0{
        didSet{
            rightViewLeadingConstraint.constant = 0
            rightViewControllerWidthConstraint.constant = -leftWidth
        }
    }
    public var menuSlideVelocity = 0.3
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){

        setupNotification()
    }
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(addLeftViewController), name: HYMenuManngerAddLeftViewName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addRightViewController), name: HYMenuManngerAddRightViewName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openMenu), name: HYMenuManngerOpenMenuName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeMenu), name: HYMenuManngerCloseMenuName, object: nil)
    }
    
    @discardableResult
    public func setupLeft(_ menuViewController:UIViewController)->HYMenuViewController{
        self.leftViewController = menuViewController
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mannger.setupPanGesture(edge:.left,view: self.leftViewController?.view)
        mannger.setupEdgeGesture(edge: .left, view: view)
        leftViewLeadingConstraint = leftViewController?.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -leftWidth)
        leftViewControllerWidthConstraint = leftViewController?.view.widthAnchor.constraint(equalToConstant: leftWidth)
        return self
    }
    @discardableResult
    public func setupRight(_ menuViewController:UIViewController)->HYMenuViewController{
        self.rightViewController = menuViewController
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mannger.setupPanGesture(edge:.right,view: self.rightViewController?.view)
        mannger.setupEdgeGesture(edge: .right, view: view)
        rightViewLeadingConstraint = rightViewController?.view.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightWidth)
        rightViewControllerWidthConstraint = rightViewController?.view.widthAnchor.constraint(equalToConstant: rightWidth)
        return self
    }
    
    @discardableResult
    public func setupCenter(_ contentViewController:UIViewController)->HYMenuViewController{
        self.centerViewController = contentViewController
        guard let centerViewController = centerViewController else {
            return self
        }

        addChild(centerViewController)
        view.addSubview(centerViewController.view)
        centerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let contentleading = centerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let contenttrailing = centerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let contentbottom = centerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let contenttop = centerViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        view.addConstraints([contenttop,contentbottom,contentleading,contenttrailing])
        return self
    }
    
    @objc func addLeftViewController(){
        guard let leftViewController = leftViewController else {
            return
        }
        if view.subviews.contains(leftViewController.view){
            return
        }
        addChild(leftViewController)
        view.addSubview(leftViewController.view)
        leftViewController.didMove(toParent: self)
        setupLeftMenuViewControllerLayout()
        leftViewController.view.frame = CGRect(x: -leftWidth, y: 0, width: leftWidth, height: view.frame.height)
    }
    @objc func addRightViewController(){
        guard let rightViewController = rightViewController else {
            return
        }
        if view.subviews.contains(rightViewController.view){
            return
        }
        addChild(rightViewController)
        view.addSubview(rightViewController.view)
        rightViewController.didMove(toParent: self)
        rightViewController.view.frame = CGRect(x: view.frame.width + rightWidth, y: 0, width: rightWidth, height: view.frame.height)
        setupRightMenuViewControllerLayout()
    }
    
    func setupLeftMenuViewControllerLayout(){
        guard let leftViewController = leftViewController else {
            return
        }
        leftViewController.view.translatesAutoresizingMaskIntoConstraints = false
        leftViewLeadingConstraint = leftViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -leftWidth)
        let bottom = leftViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let top = leftViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        
        leftViewControllerWidthConstraint = leftViewController.view.widthAnchor.constraint(equalToConstant: leftWidth)
        
        mannger.leftViewLeadingConstraint = leftViewLeadingConstraint
        mannger.leftViewControllerWidthConstraint = leftViewControllerWidthConstraint
        view.addConstraints([leftViewLeadingConstraint,bottom,top,leftViewControllerWidthConstraint])
    }
    func setupRightMenuViewControllerLayout(){
        guard let rightViewController = rightViewController else {
            return
        }
        rightViewController.view.translatesAutoresizingMaskIntoConstraints = false
        rightViewLeadingConstraint = rightViewController.view.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        let bottom = rightViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let top = rightViewController.view.topAnchor.constraint(equalTo: view.topAnchor)

        rightViewControllerWidthConstraint = rightViewController.view.widthAnchor.constraint(equalToConstant: rightWidth)

        mannger.rightViewLeadingConstraint = rightViewLeadingConstraint
        mannger.rightViewControllerWidthConstraint = rightViewControllerWidthConstraint
        view.addConstraints([rightViewLeadingConstraint,bottom,top,rightViewControllerWidthConstraint])
    }
    
    @objc  func openMenu(notification: Notification){
        guard let edges = notification.object as? SlideSide else{
            return
        }

        openSideMenu(edges: edges)
    }
    @objc func closeMenu(notification: Notification){
        guard let edges = notification.object as? SlideSide else{
            return
        }
        closeSideMenu(edges: edges)
        
    }
    public func openSideMenu(edges:SlideSide){
        switch edges {
        case .left:
            addLeftViewController()
            UIView.animate(withDuration: menuSlideVelocity) {
                self.leftViewLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        case .right:
            addRightViewController()
            UIView.animate(withDuration: menuSlideVelocity) {
                self.rightViewLeadingConstraint.constant = -self.rightViewControllerWidthConstraint.constant
                self.view.layoutIfNeeded()
            }
            break
        }
        self.delegate?.HYMenuViewControllerMenuDid(open: true, edges: edges)
    }
    public func closeSideMenu(edges:SlideSide){
        switch edges {
        case .left:
            UIView.animate(withDuration: menuSlideVelocity) {
                self.leftViewLeadingConstraint.constant = -self.leftWidth
                self.view.layoutIfNeeded()
            }completion: { complete in
                guard let leftViewController = self.leftViewController else {
                    return
                }
                leftViewController.view.removeFromSuperview()
                leftViewController.willMove(toParent: nil)
                leftViewController.removeFromParent()
            }
        case .right:
            UIView.animate(withDuration: menuSlideVelocity) {
                self.rightViewLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }completion: { complete in
                guard let rightViewController = self.rightViewController else {
                    return
                }

                rightViewController.view.removeFromSuperview()
                rightViewController.willMove(toParent: nil)
                rightViewController.removeFromParent()
            }
            break
        }
        self.delegate?.HYMenuViewControllerMenuDid(open: false, edges: edges)
    }
}
