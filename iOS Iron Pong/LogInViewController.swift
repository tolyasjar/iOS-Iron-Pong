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
                    
                    self.saveCurrentUser()

                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "SignInSegue", sender: self)

                        
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        let alertController = UIAlertController(title: "Oops!", message: "Invalid Email or Password", preferredStyle: .alert)
                        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                            UIAlertAction in
                        }
                        alertController.addAction(dismissAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
        })
        
        dataTask.resume()
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
        
        self.authUser()

        
    }
    
    func saveCurrentUser() {
        
        let nickName = self.currentUser.nickName
        let _id =  self.currentUser.id
        
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set( nickName, forKey: "nickName")
        userDefaults.set( _id, forKey: "_id")

        userDefaults.synchronize()
        
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        
    }
    
//    @IBAction func reclaimOldAccountButtonPressed() {
//        
//    }
//    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }


}
