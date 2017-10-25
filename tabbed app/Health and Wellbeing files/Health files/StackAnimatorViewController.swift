//
//  StackAnimatorViewController.swift
//  Speak Out!
//
//  Created by admin on 05/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.
//

import UIKit

class StackAnimatorViewController: UIViewController, UICollisionBehaviorDelegate {
    
    // This can taken from the DB model
    var dataModel = ["What is", "Symptoms", "How to handle it", "Know more"]
    
    var dataContent = ["bla bla",
                       "bla bla bla bla",
                       "bla bla..",
                       "Bla"]
    
    var dataURLS = ["https://www.linkedin.com", "https://www.linkedin.com",
                    "https://www.linkedin.com", "https://www.linkedin.com",]
    
    var views = [UIView]()
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var snap:UISnapBehavior!
    // To calculate movement that we apply to the views
    var previousTouchPoint:CGPoint!
    var viewDragging = false
    var viewPinned = false
    
    func changeDataModels() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDataModels()
        
        // Init animator with reference view as self.view
        // becuase is where all the action is going to happen
        animator = UIDynamicAnimator(referenceView: self.view)
        // Init gravity
        gravity = UIGravityBehavior()
        
        animator.addBehavior(gravity)
        gravity.magnitude = 4 // Good value
        
        var offset:CGFloat = 250
        
        for i in  0 ... dataModel.count - 1 {
            if let view = addViewController(atOffset: offset, dataForVC: dataModel[i] as AnyObject, dataContent: dataContent[i] as AnyObject?, dataURLS: dataURLS[i] as AnyObject?) {
                views.append(view)
                offset -= 50
            }
        }
    }

    // To add stack elements to the screen at the given offset
    // NB: AnyObject data because it depends from model (eg: string, view, custom object )
    func addViewController (atOffset offset: CGFloat, dataForVC dataModel: AnyObject?, dataContent: AnyObject?, dataURLS: AnyObject?) -> UIView? {
        // Create i nstance of custom stack element view controller
        
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let stackElementVC = sb.instantiateViewController(withIdentifier: "StackElement") as! StackElementViewController
        
        if let view = stackElementVC.view {
            view.frame = frameForView
            view.layer.cornerRadius = 5
            // Create drop shadow
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor =  UIColor.black.cgColor
            view.layer.shadowRadius =  3
            view.layer.shadowOpacity = 0.5
            
            // Add data to view controller
            // Casting from AnyObject required (to a string)
            if let headerStr = dataModel as? String {
                stackElementVC.headerString = headerStr
            }
            
            if let bodyStr = dataContent as? String {
                stackElementVC.bodyString = bodyStr
            }
            
            if let buttonLink = dataURLS as? String {
                stackElementVC.urlForButton = buttonLink
            }
            
            self.addChildViewController(stackElementVC)
            self.view.addSubview(view)
            stackElementVC.didMove(toParentViewController: self)
            
            // Animations/Behaviour fro dragging/pan actions
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(StackAnimatorViewController.handlePan(gestureRecognizer:)))
            view.addGestureRecognizer(panGestureRecognizer)
            
            // Collision Behaviour
            let collision = UICollisionBehavior(items: [view])
            collision.collisionDelegate = self
            animator.addBehavior(collision)
            // Lower boundary
            let boundary = view.frame.origin.y + view.frame.size.height
            var boundaryStart = CGPoint(x: 0, y: boundary)
            var boundaryEnd = CGPoint(x: self.view.bounds.size.width, y: boundary)
            collision.addBoundary(withIdentifier: 1 as NSCopying, from: boundaryStart, to: boundaryEnd)
            // Upper boundary
            boundaryStart = CGPoint(x: 0, y: 0)
            boundaryEnd = CGPoint(x: self.view.bounds.size.width, y: 0)
            collision.addBoundary(withIdentifier: 2 as NSCopying, from: boundaryStart, to: boundaryEnd)
            
            // Apply gravity force
            gravity.addItem(view)
            
            let itemBehavior = UIDynamicItemBehavior(items: [view])
            animator.addBehavior(itemBehavior)
            
            return view
        }
        return nil
    }
    
    // Action to place in the panGestureRecognizer init
    func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: self.view)
        let draggedView = gestureRecognizer.view!
        
        if gestureRecognizer.state == .began {
            let dragStartPoint = gestureRecognizer.location(in: draggedView)
            
            if dragStartPoint.y < 200 {
                viewDragging = true
                previousTouchPoint = touchPoint
            }
        } else if gestureRecognizer.state == .changed && viewDragging {
            let yOffset = previousTouchPoint.y - touchPoint.y
            draggedView.center = CGPoint(x: draggedView.center.x, y: draggedView.center.y - yOffset)
            previousTouchPoint = touchPoint
        } else if gestureRecognizer.state == .ended && viewDragging {
            
            // Pin
            pin(view: draggedView)
            
            // AddVelocity
            addVelocity(toView: draggedView, fromGestureReconizer: gestureRecognizer)
            
            animator.updateItem(usingCurrentState: draggedView)
            viewDragging = false
            
        }
    }
    
    func pin(view: UIView) {
        
        let viewHasReachedPinLocation =  view.frame.origin.y < 100
        
        if viewHasReachedPinLocation {
            if !viewPinned {
                var snapPosition = self.view.center
                snapPosition.y += 30
                
                snap = UISnapBehavior(item: view, snapTo: snapPosition)
                animator.addBehavior(snap)
                
                // setVisibility alpha 0
                setVisibility(view: view, alpha: 0)
                
                viewPinned = true
            }
        } else {
            if viewPinned {
                animator.removeBehavior(snap)
                
                // setVisibility alpha 1
                setVisibility(view: view, alpha: 1)
                viewPinned  = false
            }
        }
    }
    
    func setVisibility(view:UIView, alpha:CGFloat) {
        // For all the views different from the current one in action (given in the parameter)
        for aView in views {
            if aView != view {
                aView.alpha = alpha
            }
        }
    }
    
    func addVelocity(toView view:UIView, fromGestureReconizer panGesture:UIPanGestureRecognizer) {
        // Convert the pan velocity to specific items velocity
        var velocity = panGesture.velocity(in: self.view)
        //  We do not wnat to move it left/right
        velocity.x = 0
        
        // Add this velocity to the right behavior
        if let behavior = itemBehavior(forView: view) {
            behavior.addLinearVelocity(velocity, for: view)
        }
        
    }
    // Iterates all the behaviors until it finds the right one
    func itemBehavior(forView view:UIView) -> UIDynamicItemBehavior? {
        for behavior in animator.behaviors {
            if let itemBehavoir = behavior as? UIDynamicItemBehavior {
                if let possibleView = itemBehavoir.items.first as? UIView, possibleView == view {
                    return itemBehavoir
                }
            }
        }
        return nil
    }
    
    // Implement specific delegate
    // This is triggered when a collision happen
    // We need to check the boundarywith the identifier 2
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        // THIS CAN THROW AN EXCEPTION IF ID IS NOT INT
        if 2 == identifier as! Int {
            let view = item as! UIView
            pin(view: view)
        }
        
    }
}
