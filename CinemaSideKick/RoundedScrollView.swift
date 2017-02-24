//
//  RoundedScrollView.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 2/23/17.
//
//

import Foundation

class RoundedScrollView: UIScrollView {
    
    override func awakeFromNib() {
        
        self.layoutIfNeeded()
        layer.cornerRadius = 10
        //layer.cornerRadius = self.frame.height / 2.0
        layer.masksToBounds = true
        
    }
}
