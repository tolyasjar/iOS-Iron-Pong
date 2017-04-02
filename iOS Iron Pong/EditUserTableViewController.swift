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
    
    var currentUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTxtField.text = currentUser.email
        self.passwordTxtField.text = currentUser.password
        self.nickNameTxtField.text = currentUser.nickName
        
        self.homeTownTxtField.text = currentUser.homeTown
        self.signatureMoveTxtField.text = currentUser.signatureMove
        self.paddleGripStyleTxtField.text = currentUser.paddleGripStyle
        self.catchphraseTxtField.text = currentUser.catchPhrase
        
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
        user.catchPhrase = catchphraseTxtField.text
        
        self.updatingUserProfiledelegate.updateProfileDidSave(user)
        
        // PUT to API
        
        let url = "https://iron-pong.herokuapp.com/api/users/58e03706f36d2878e036c661"
        
        guard let apiURL = NSURL(string: url) else {
            fatalError("URL incorrect")
        }
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: apiURL as URL)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters = ["email": emailTxtField.text! ,"password": passwordTxtField.text! ,"nickName": nickNameTxtField.text!, "homeTown": homeTownTxtField.text!,"signatureMove" : signatureMoveTxtField.text!,"paddleGripStyle": paddleGripStyleTxtField.text!, "catchPhrase" : catchphraseTxtField.text! ] as [String : Any]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        session.dataTask(with: request as URLRequest) { (data :Data?, response :URLResponse?, error: Error?) in
            
            print("finished")
            
            }.resume()

        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

