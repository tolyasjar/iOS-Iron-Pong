//
//  CurrentUserTableViewController.swift
//  iOS Iron Pong
//
//  Created by Toleen Jaradat on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class CurrentUserTableViewController: UITableViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var catchPhraseLbl: UILabel!
    @IBOutlet weak var paddleGripStyleLbl: UILabel!
    
    @IBOutlet weak var signatureMoveLbl: UILabel!
    @IBOutlet weak var homeTownLbl: UILabel!
    @IBOutlet weak var winsLbl: UILabel!
    @IBOutlet weak var lossesLbl: UILabel!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateDummyUsers()
        // Assumption CurrentUser = users[0]
        let currentUser = users[0]
        self.nameLbl.text = currentUser.name
        self.emailLbl.text = currentUser.email
        self.passwordLbl.text = currentUser.password
        self.homeTownLbl.text = currentUser.homeTown
        self.paddleGripStyleLbl.text = currentUser.paddleGripStyle
        self.signatureMoveLbl.text = currentUser.signatureMove
        self.winsLbl.text = "\(currentUser.wins!)"
        self.lossesLbl.text = "\(currentUser.losses!)"
        self.catchPhraseLbl.text = currentUser.catchPrase
        
    }
    
    func populateDummyUsers() {
        
        
        if let path = Bundle.main.path(forResource: "mockUserAPI", ofType: "json") {
            do {
                
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                
                do {
                    
                    let jsonDict = try! JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
                    
                    for item in jsonDict {
                        let user = User()
                        user.name = item["name"] as? String
                        user.email = item["email"] as? String
                        user.password = item["password"] as? String
                        user.avatarURL = item["avatarURL"] as? String
                        user.catchPrase = item ["catchPrase"] as? String
                        user.signatureMove = item["signatureMove"] as? String
                        user.paddleGripStyle = item["paddleGripStyle"] as? String
                        user.homeTown = item["homeTown"] as? String
                        user.wins = item["wins"] as? Double
                        user.losses = item["losses"] as? Double
                        user.winStreak = item["winStreak"] as? Double
                        user.totalGames = item["totalGames"] as? Double
                        
                        users.append(user)
                        print(item)
                    }
                    
                }
            } catch {}
        }
    }
    
    
    //MARK:- Edit Alert box will be displayed
    @IBAction func editButtonPressed(_ sender: Any) {
        
        
        
        
    }
    
}
