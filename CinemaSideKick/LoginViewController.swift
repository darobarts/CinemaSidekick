//
//  LoginViewController.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 2/26/17.
//
//

import Foundation
import UIKit
import FirebaseAuth
import FacebookLogin

@IBDesignable
class LoginViewController: UIViewController, LoginButtonDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up facebook login button
        let loginButton = LoginButton(readPermissions: [.publicProfile, .email])
        loginButton.center = view.center
        
        loginButton.delegate = self
        
        view.addSubview(loginButton)

    }
    
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
                    self.performSegue(withIdentifier: "mainSegue", sender: nil)

                    //let movieView = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
                    //self.navigationController?.pushViewController(movieView!, animated: true)
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
