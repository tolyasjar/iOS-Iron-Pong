//
//  UserProfileViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var selectedUser = User()
    
    @IBOutlet var avatharView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var nickNameLabel: UILabel!
    
    @IBOutlet var winsLabel: UILabel!
    
    @IBOutlet var winStreakLabel: UILabel!
    
    @IBOutlet var winRatioLabel: UILabel!
    
    @IBOutlet var totalGamesLabel: UILabel!
    
    @IBOutlet var homeTownLabel: UILabel!
    
    @IBOutlet var paddleGripStyleLabel: UILabel!
    
    @IBOutlet var signatureMoveLabel: UILabel!
    
    @IBOutlet var catchPhraseLabel: UILabel!
    
    @IBAction func usersButtonPresseed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.nameLabel.text = selectedUser.nickName
        self.nickNameLabel.text = selectedUser.nickName
        self.winsLabel.text = String (describing: selectedUser.wins!)
        self.winStreakLabel.text = String(describing: selectedUser.winStreak!)
        self.winRatioLabel.text = String(describing: selectedUser.winRatio!)
        self.totalGamesLabel.text = String(describing: selectedUser.totalGames!)
        self.homeTownLabel.text = selectedUser.homeTown
        self.paddleGripStyleLabel.text = selectedUser.paddleGripStyle
        self.signatureMoveLabel.text = selectedUser.signatureMove
        self.catchPhraseLabel.text = selectedUser.catchPhrase
        
        self.navigationItem.title = self.selectedUser.nickName
    }
    
    
}
