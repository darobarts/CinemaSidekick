//
//  FacebookLoginDelegate.swift
//  CinemaSideKick
//
//  Created by Austin Robarts on 3/2/17.
//
//

import Foundation
import FacebookLogin
import FacebookCore
import FirebaseAuth

class FacebookLoginDelegate : LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .cancelled:
            print("Login cancelled")
            break
        case .success( _, _, let token):
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
            FIRAuth.auth()?.signIn(with: credential) {(user, error) in
                //if there is an error
                if error != nil {
                    print("There was an error: " + (error?.localizedDescription)!)
                    return
                }
                //upload user to Firebase
                if user != nil {
                    let uploader = FirebaseUploader()
                    uploader.addUser(user: User(id: (user?.uid)!, name: (user?.displayName)!))
                    //move displays to next View
                }
                
            }
            break
        case .failed(let error):
            print("Login Failed: " + error.localizedDescription)
            break
            
        }
        //call firebase with access token
        
     }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        //deal with facebook logout
    }
    
}
