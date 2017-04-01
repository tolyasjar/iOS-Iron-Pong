//
//  EditUserProfileTableViewController.swift
//  iOS Iron Pong
//
//  Created by Toleen Jaradat on 4/1/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class EditUserProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var avatarbtn: UIButton!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nickNameTxtField: UITextField!
    
    @IBOutlet weak var homeTownTxtField: UITextField!
    @IBOutlet weak var signatureMoveTxtField: UITextField!
    @IBOutlet weak var paddleGripStyleTxtField: UITextField!
    @IBOutlet weak var catchphraseTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func avatarBtnPressed(_ sender: Any) {
        //Take a pic
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        // Save user to DB
        self.dismiss(animated: true, completion: nil)
    }
}

