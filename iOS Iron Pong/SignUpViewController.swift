//
//  SignUpViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var user = User()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        

        if self.emailTextField.text == "" {
            
            let alertController = UIAlertController(title: "Oops", message: "Enter a email address.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.user.email = self.emailTextField.text
        }
        
        if self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "Enter a email password.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.user.password = self.passwordTextField.text
        }
        
        if self.nameTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "Enter a name.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.user.name = self.nameTextField.text
        }
        
        self.performSegue(withIdentifier: "SignUpSegue", sender: self)

        
    }


}
