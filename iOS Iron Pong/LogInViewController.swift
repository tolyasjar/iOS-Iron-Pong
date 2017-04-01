//
//  LogInViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self

    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if self.emailTextField.text == "" {
            
            let alertController = UIAlertController(title: "Oops!", message: "Enter a email address.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.currentUser.email = self.emailTextField.text
        }
        
        if self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Enter a email password.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.currentUser.password = self.passwordTextField.text
        }
        
        self.performSegue(withIdentifier: "SignInSegue", sender: self)

        
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
