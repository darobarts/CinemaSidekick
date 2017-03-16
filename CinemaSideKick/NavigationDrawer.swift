//
//  NavigationDrawer.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/16/17.
//
//

import Foundation
import UIKit
import SlideMenuControllerSwift

@IBDesignable
class NavigationDrawer: SlideMenuController {
    
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "NavigationDrawer") {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }
}
