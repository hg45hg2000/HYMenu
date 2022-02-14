//
//  HYMenuMannger.swift
//  HYMenu
//
//  Created by HENRY on 2022/2/14.
//

import Foundation
public enum SlideSide{
    case left,right
}

let HYMenuManngerAddLeftViewName = Notification.Name("AddLeftView")

let HYMenuManngerAddRightViewName = Notification.Name("AddRightView")

let HYMenuManngerOpenMenuName = Notification.Name("OpenMenu")

let HYMenuManngerCloseMenuName = Notification.Name("CloseMenu")

class HYMenuMannger{
    var leftViewLeadingConstraint :NSLayoutConstraint!
    
    var leftViewControllerWidthConstraint : NSLayoutConstraint!
    
    var rightViewLeadingConstraint :NSLayoutConstraint!
    
    var rightViewControllerWidthConstraint : NSLayoutConstraint!
    
    init(){
        
    }
    
    func setupEdgeGesture(edge:SlideSide,view:UIView){
        switch edge {
        case .left:
            let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftGesture(gesture:)))
            edgeGesture.edges = .left
            view.addGestureRecognizer(edgeGesture)
        case .right:
            let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleRightGesture(gesture:)))
            edgeGesture.edges = .right
            view.addGestureRecognizer(edgeGesture)
            break
        }
    }
    func setupPanGesture(edge:SlideSide,view:UIView?){
        switch edge {
        case .left:
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleLeftGesture(gesture:)))
            view?.addGestureRecognizer(panGesture)
        case .right:
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleRightGesture(gesture:)))
            view?.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func handleLeftGesture(gesture: UIPanGestureRecognizer){
        NotificationCenter.default.post(name:HYMenuManngerAddLeftViewName , object: nil)
        let menuView = gesture.view
        let transaltion = gesture.translation(in: menuView)
        let x = leftViewLeadingConstraint.constant + transaltion.x
        switch gesture.state{
        case .changed:
            if x > 0 {
                break
            }
            else{
                leftViewLeadingConstraint.constant += transaltion.x
            }
            gesture.setTranslation(CGPoint.zero, in: menuView)
        case .ended:
            let open = leftViewLeadingConstraint.constant > -leftViewControllerWidthConstraint.constant / 2
            if open{
                NotificationCenter.default.post(name: HYMenuManngerOpenMenuName, object: SlideSide.left)
            }else{
                NotificationCenter.default.post(name: HYMenuManngerCloseMenuName, object: SlideSide.left)
            }
        default:break
        }
    }
    @objc func handleRightGesture(gesture: UIPanGestureRecognizer){
        NotificationCenter.default.post(name:HYMenuManngerAddRightViewName , object: nil)
        let menuView = gesture.view
        let transaltion = gesture.translation(in: menuView)
        let x = -(rightViewLeadingConstraint.constant + transaltion.x)
        switch gesture.state{
        case .changed:
            if  rightViewControllerWidthConstraint.constant <= x{
                break
            }
            else{
                rightViewLeadingConstraint.constant += transaltion.x
            }
            gesture.setTranslation(CGPoint.zero, in: menuView)
        case .ended:
            let open = -rightViewLeadingConstraint.constant > rightViewControllerWidthConstraint.constant / 2
            if open{
                NotificationCenter.default.post(name: HYMenuManngerOpenMenuName, object: SlideSide.right)
            }else{
                NotificationCenter.default.post(name: HYMenuManngerCloseMenuName, object: SlideSide.right)
            }
        default:break
        }
    }
}
