//
//  ReclaimOldAccountViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 4/1/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class ReclaimOldAccountViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var oldAccountId :String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func findUser() {
        
        
        let url = URL(string: "https://iron-pong.herokuapp.com/API/users")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for dictionary in json {
                print(dictionary)
                
                if dictionary["nickName"] == self.nameTextField.text! || dictionary["claimed"] == false {
               
                    self.oldAccountId = dictionary["_id"]
                    
                } else {
                    
                    // user not found or already claimed
                    
                }
                
            }
            }.resume()
        
    }
    
    @IBAction func submitButtonPressed() {
        
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
