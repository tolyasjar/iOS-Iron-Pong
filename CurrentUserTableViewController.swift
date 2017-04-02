//
//  CurrentUserTableViewController.swift
//  iOS Iron Pong
//
//  Created by Toleen Jaradat on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class CurrentUserTableViewController: UITableViewController, UpdatingProfile {
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var nicknameLbl: UILabel!
    
    @IBOutlet weak var homeTownLbl: UILabel!
    @IBOutlet weak var signatureMoveLbl: UILabel!
    @IBOutlet weak var paddleGripStyleLbl: UILabel!
    @IBOutlet weak var catchPhraseLbl: UILabel!
    
    @IBOutlet weak var winsLbl: UILabel!
    @IBOutlet weak var lossesLbl: UILabel!
    @IBOutlet weak var winstreakLbl: UILabel!
    @IBOutlet weak var winRatioLbl: UILabel!
    @IBOutlet weak var totalGamesLbl: UILabel!
    
    var currentUser = User()
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateDummyUsers()
        // Assumption CurrentUser = users[0]
        currentUser = users[0]
        
        
        self.emailLbl.text = currentUser.email
        self.passwordLbl.text = currentUser.password
        self.nicknameLbl.text = currentUser.nickName
        
        self.homeTownLbl.text = currentUser.homeTown
        self.signatureMoveLbl.text = currentUser.signatureMove
        self.paddleGripStyleLbl.text = currentUser.paddleGripStyle
        self.catchPhraseLbl.text = currentUser.catchPhrase
        
        self.winsLbl.text = "\(currentUser.wins!)"
        self.lossesLbl.text = "\(currentUser.losses!)"
        //self.winRatioLbl.text = "\(currentUser.winRatio!)"
        //self.winstreakLbl.text = "\(currentUser.winStreak!)"
        //self.totalGamesLbl.text = "\(currentUser.totalGames!)"
        
    }
    
    func populateDummyUsers() {
        
        
        if let path = Bundle.main.path(forResource: "mockUserAPI", ofType: "json") {
            do {
                
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                
                do {
                    
                    let jsonDict = try! JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
                    
                    for item in jsonDict {
                        let user = User()
                        user.email = item["email"] as? String
                        user.password = item["password"] as? String
                        user.nickName = item["nickName"] as? String
                        user.avatarURL = item["avatarURL"] as? String
                        
                        user.homeTown = item["homeTown"] as? String
                        user.signatureMove = item["signatureMove"] as? String
                        user.paddleGripStyle = item["paddleGripStyle"] as? String
                        user.catchPhrase = item ["catchPhrase"] as? String
                        
                        user.wins = item["wins"] as? Double
                        user.losses = item["losses"] as? Double
                        user.winStreak = item["winStreak"] as? Double
                        user.winRatio = item["winRatio"] as? Double
                        user.totalGames = item["totalGames"] as? Double
                        
                        users.append(user)
                        print(item)
                    }
                    
                }
            } catch {}
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height =  0.001
        return CGFloat(height)
    }
    
    //MARK:- Edit Alert box will be displayed
    @IBAction func editButtonPressed(_ sender: Any) {
        
        
    }
    
    func updateProfileDidSave(_ user: User) {
        
        //update UI
        self.emailLbl.text = user.email
        self.passwordLbl.text = user.password
        self.nicknameLbl.text = user.nickName
        
        self.homeTownLbl.text = user.homeTown
        self.signatureMoveLbl.text = user.signatureMove
        self.paddleGripStyleLbl.text = user.paddleGripStyle
        self.catchPhraseLbl.text = user.catchPhrase

        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController = segue.destination as? UINavigationController
            else {
                    fatalError("Destination controller not found")
                }
        
            let editUserTableViewController = nextViewController.topViewController as? EditUserProfileTableViewController
            editUserTableViewController?.updatingUserProfiledelegate = self
            editUserTableViewController?.currentUser = currentUser
        
        }
    
}
