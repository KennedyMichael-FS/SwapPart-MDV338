//
//  AuthViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/28/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class AuthViewController: UIViewController {
    
    var email : String = ""
    var password : String = ""
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signUp(_ sender: UIButton) {
        email = emailField.text ?? ""
        password = passwordField.text ?? ""
        AttemptSignup()
    }
    @IBAction func signIn(_ sender: UIButton) {
        email = emailField.text ?? ""
        password = passwordField.text ?? ""
        AttemptSignin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        
    }
    
    func AttemptSignup() {
        Auth.auth().createUser(withEmail: email, password: password)
        AttemptSignin()
    }
    
    func AttemptSignin() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        }
    }
    
    func AttemptSignout() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Something happened that shouldn't have whilst signing out.")
        }
    }
    
}
