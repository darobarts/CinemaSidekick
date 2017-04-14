//
//  SwipeToChooseView.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 3/9/17.
//
//

import Foundation
import UIKit
import MDCSwipeToChoose

class SwipeToChooseCusomView: UIView {
    
    // Creating and Customizing a MDCSwipeToChooseView
    
    func viewDidLoad(){
//        super.viewDidLoad()
        
        // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
        var options:MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        //options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blue
        options.nopeText = "Delete"
        options.onPan = { state -> Void in
            if (state?.thresholdRatio == 1.0 && state?.direction == MDCSwipeDirection.left) {
                print("Let go now to delete the photo!")
            }
        }
        
        var view:MDCSwipeToChooseView = MDCSwipeToChooseView(frame:self.bounds, options:options)
        view.imageView.image = UIImage(named:"photo")
        view.addSubview(view)
    }
    
    // MDCSwipeToChooseDelegate Callbacks
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(view: UIView) -> Void{
        print("Couldn't decide, huh?")
    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(view:UIView, shouldBeChosenWithDirection:MDCSwipeDirection) -> Bool {
        if (shouldBeChosenWithDirection == MDCSwipeDirection.left) {
            return true;
        } else {
            // Snap the view back and cancel the choice.
            UIView.animate(withDuration: 0.16, animations: { () -> Void in
                view.transform = CGAffineTransform.identity
                view.center = self.center
            })
            return false;
        }
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        if (wasChosenWithDirection == MDCSwipeDirection.left) {
            print("Photo deleted!");
        } else {
            print("Photo saved!");
        }
    }

}
