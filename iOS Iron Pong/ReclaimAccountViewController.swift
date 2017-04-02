//
//  ReclaimAccountViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 4/2/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class ReclaimAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    var accountId :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.nameTextField.delegate = self
    }
    
    func findUser() {
        
        
        let url = URL(string: "https://iron-pong.herokuapp.com/API/users")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for dictionary in json {
                print(dictionary)
                let nickName = dictionary["nickName"] as! String
                if dictionary["claimed"] == nil {
                    
                } else {
                    
                    
                    let claimed = dictionary["claimed"] as! Bool
                    
                    if nickName == self.nameTextField.text! && claimed == false {
                        
                        self.accountId = dictionary["_id"] as! String
                        
                    } else {
                        
                        
                    }
                }
                
            }
            
            DispatchQueue.main.async {
                
                if self.accountId == nil {
                    //user name not found
                    
                    let alertController = UIAlertController(title: "Oops!", message: "User Not Found or Already Claimed", preferredStyle: .alert)
                    let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                        UIAlertAction in
                    }
                    alertController.addAction(dismissAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    
                    let alertController = UIAlertController(title: "Nice!", message: "User Found", preferredStyle: .alert)
                    let continueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        self.performSegue(withIdentifier: "ReclaimOldAccountSegue", sender: self)
                        
                    }
                    let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                        UIAlertAction in
                        self.accountId = nil
                    }
                    alertController.addAction(continueAction)
                    alertController.addAction(dismissAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            }.resume()
        
    }
    
    @IBAction func submitButtonPressed() {
        
        if self.nameTextField.text == "" {
            //enter in a user name
            
            let alertController = UIAlertController(title: "Oops!", message: "Enter a User Name", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            //finds the user
            self.findUser()
                      
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ReclaimOldAccountSegue" {
            
            let updateOldAccountVC = segue.destination as! UpdateOldAccountViewController
            
            updateOldAccountVC.accountId = self.accountId

            
        }
        
    }

    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
