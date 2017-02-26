//
//  LoginViewController.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 2/26/17.
//
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.userLogin.delegate = self
        self.passwordLogin.delegate = self

    }
    
    //called when the "done" button is clicked for username field
    @IBAction func usernameDone(_ sender: Any) {
        self.view.endEditing(true)
        
        print("Username field: " + userLogin.text!)

    }
    
    //called when the "done" button is clicked for password field
    @IBAction func passwordDone(_ sender: Any) {
        self.view.endEditing(true)
        print("Password field: " + passwordLogin.text!)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userLogin.resignFirstResponder()
        passwordLogin.resignFirstResponder()
        return true;
    }
}
