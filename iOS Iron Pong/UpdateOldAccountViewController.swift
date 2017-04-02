//
//  UpdateOldAccountViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 4/1/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class UpdateOldAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!

    var accountId :String!
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func updateButtonPressed() {
        
        if self.emailTextField.text == "" && self.passwordTextField.text == "" && self.nameTextField.text == "" {
            
            let alertController = UIAlertController(title: "Oops!", message: "Please fill in required fields", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            self.updateUser()
            
        }
    }
    
    
    func updateUser() {
        
        let headers = [
            "authorization": "Bearer gUUfpJRjmPaVD2MTlibrrFtbded88WdJPiEG_u19CINNBRn7xiaG7gPWAoryBEwJ5289zNwANOtVQuRvQTJVdc2Ukblq72in08ryy0zZQYyaDQxHzp6a7vFqLkzZWHYx",
            "content-type": "application/json",
            "cache-control": "no-cache",
        ]
        let parameters = [
            "nickName": self.nameTextField.text!,
            "email": self.emailTextField.text!,
            "password": self.passwordTextField.text!,
            "claimed": true
            ] as [String : Any]
        
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
 
        let request = NSMutableURLRequest(url: NSURL(string: "https://iron-pong.herokuapp.com/api/users/\(accountId!)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "PUT"
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


    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
