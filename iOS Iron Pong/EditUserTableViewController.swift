//
//  EditUserProfileTableViewController.swift
//  iOS Iron Pong
//
//  Created by Toleen Jaradat on 4/1/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

protocol UpdatingProfile: class {
    
    func updateProfileDidSave(_ user: User)
}

class EditUserProfileTableViewController: UITableViewController, UITextFieldDelegate  {
    
    weak var updatingUserProfiledelegate: UpdatingProfile!
    
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
        let user = User()
        user.email = emailTxtField.text
        user.password = passwordTxtField.text
        user.nickName = nickNameTxtField.text
        
        user.homeTown  = homeTownTxtField.text
        user.signatureMove  = signatureMoveTxtField.text
        user.paddleGripStyle  = paddleGripStyleTxtField.text
        user.catchPhrase = nickNameTxtField.text
        
        self.updatingUserProfiledelegate.updateProfileDidSave(user)

        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

