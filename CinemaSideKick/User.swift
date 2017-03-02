//
//  User.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/1/17.
//
//

import Foundation

class User {
    
    var id: String
    var wishList : NSDictionary
    var seenList : NSDictionary
    
    init(id : String) {
        self.id = id
        wishList = NSDictionary()
        seenList = NSDictionary()
    }
    
    init(id : String, wishList : NSDictionary, seenList : NSDictionary) {
        self.id = id
        self.wishList = wishList
        self.seenList = seenList
    }
    
    
}
