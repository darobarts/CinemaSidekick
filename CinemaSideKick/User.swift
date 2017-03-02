//
//  User.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/1/17.
//
//

import Foundation

class User {
    var name : String
    var id: String
    var wishList : NSDictionary
    var seenList : NSDictionary
    
    init(id : String, name : String) {
        self.id = id
        self.name = name
        wishList = NSDictionary()
        seenList = NSDictionary()
    }
    
    init(id : String, name : String, wishList : NSDictionary, seenList : NSDictionary) {
        self.id = id
        self.name = name
        self.wishList = wishList
        self.seenList = seenList
    }
    
    func getDictView() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        dict["id"] = id
        dict["name"] = name
        dict["wishList"] = wishList
        dict["seenList"] = seenList
        return dict
    }
    
    
}
