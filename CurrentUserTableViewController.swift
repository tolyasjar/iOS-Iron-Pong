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
        
        getCurrentUser()

        //populateDummyUsers()
        
        // Assumption CurrentUser = users[0]
       // currentUser = users[0]
        
        
        //self.winRatioLbl.text = "\(currentUser.winRatio!)"
        //self.winstreakLbl.text = "\(currentUser.winStreak!)"
        //self.totalGamesLbl.text = "\(currentUser.totalGames!)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCurrentUser()
        }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    func getCurrentUser(){
        
            let url = URL(string: "https://iron-pong.herokuapp.com/api/users/\(currentUser.id!)")!
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                self.currentUser.email = json["email"] as? String
                self.currentUser.nickName = json["nickName"] as? String
                self.currentUser.avatarURL = json["avatarURL"] as? String
                
                self.currentUser.homeTown = json["homeTown"] as? String
                self.currentUser.signatureMove = json["signatureMove"] as? String
                self.currentUser.paddleGripStyle = json["paddleGripStyle"] as? String
                self.currentUser.catchPhrase = json ["catchPhrase"] as? String
                
                self.currentUser.wins = json["wins"] as? Double
                self.currentUser.losses = json["losses"] as? Double
                self.currentUser.winStreak = json["winStreak"] as? Double
                self.currentUser.winRatio = json["winRatio"] as? Double
                self.currentUser.totalGames = json["totalGames"] as? Double
                
                DispatchQueue.main.async {
                    
                    if (self.currentUser.email != nil) {
                        self.emailLbl.text = self.currentUser.email
                    }
                    if (self.currentUser.nickName != nil) {
                        self.nicknameLbl.text = self.currentUser.nickName
                    }
                    
                    
                    if (self.currentUser.homeTown != nil) {
                        self.emailLbl.text = self.currentUser.homeTown
                    }
                    if (self.currentUser.signatureMove != nil) {
                        self.signatureMoveLbl.text = self.currentUser.signatureMove
                    }
                    if (self.currentUser.paddleGripStyle != nil) {
                        self.paddleGripStyleLbl.text = self.currentUser.paddleGripStyle
                    }
                    if (self.currentUser.catchPhrase != nil) {
                        self.catchPhraseLbl.text = self.currentUser.catchPhrase
                    }
                    
                    if (self.currentUser.wins != nil) {
                        self.winsLbl.text = "\(self.currentUser.wins!)"
                    }
                    
                    if (self.currentUser.losses != nil) {
                        self.lossesLbl.text = "\(self.currentUser.losses!)"
                    }
                    if (self.currentUser.winRatio != nil) {
                        self.winRatioLbl.text = "\(self.currentUser.winRatio!)"
                    }
                    if (self.currentUser.winStreak != nil) {
                        self.totalGamesLbl.text = "\(self.currentUser.winStreak!)"
                    }
                    if (self.currentUser.totalGames != nil) {
                        self.totalGamesLbl.text = "\(self.currentUser.totalGames!)"
                    }

                    
                }
                }.resume()
            
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
        //self.passwordLbl.text = user.password
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
