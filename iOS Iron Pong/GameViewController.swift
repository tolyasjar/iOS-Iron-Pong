//
//  GameViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var otherPlayer = User()
    var currentUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = Foundation.UserDefaults.standard
        let nickName  = userDefaults.string(forKey: "nickName")
        let _id  = userDefaults.string(forKey: "_id")
        
        currentUser.nickName = nickName
        currentUser.id = _id

        // Do any additional setup after loading the view.
        
        print("current user name:\(self.currentUser.nickName!)")
        print("other user name:\(self.otherPlayer.nickName!)")
    }
    
    



}
