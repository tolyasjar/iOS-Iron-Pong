//
//  SignUpViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var currentUser = User()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.nameTextField.delegate = self

    }
    
    func authUser() {
        
        let headers = [
            "authorization": "Bearer gUUfpJRjmPaVD2MTlibrrFtbded88WdJPiEG_u19CINNBRn7xiaG7gPWAoryBEwJ5289zNwANOtVQuRvQTJVdc2Ukblq72in08ryy0zZQYyaDQxHzp6a7vFqLkzZWHYx",
            "content-type": "application/json",
            "cache-control": "no-cache",
            ]
        let parameters = [
            "email": self.emailTextField.text!,
            "password": self.passwordTextField.text!
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://iron-pong.herokuapp.com/auth/login")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                
                
                if httpResponse?.statusCode == 200 {
                    
                    let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    
                    self.currentUser.id = json["_id"] as? String
                    self.currentUser.email = json["email"] as? String
                    self.currentUser.nickName = json["nickName"] as? String
                    self.currentUser.password = json["password"] as? String
                    
                    DispatchQueue.main.async {
                        
                        self.performSegue(withIdentifier: "SignUpSegue", sender: self)
                        
                        
                    }
                    
                } else {
                    
         
                    
                }
                
            }
        })
        
        dataTask.resume()
    }

    
    
    func postNewUser() {
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
        ]
        let parameters = [
            "email": self.emailTextField.text!,
            "password": self.passwordTextField.text!,
            "nickName": self.nameTextField.text!
            ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://iron-pong.herokuapp.com/auth/register")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                
            }
        })
        
        dataTask.resume()
        
        
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        

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
        
        if self.nameTextField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Enter a name.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            self.currentUser.nickName = self.nameTextField.text
        }
// This is comment out to avoid creating a lot of user while testing       
        //self.postNewUser()
        self.authUser()

        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
