//
//  User.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import Foundation

class User {
    
    var email :String
    var password :String
    var name :String
    var avatarURL :String
    var catchPrase :String
    var paddleGripStyle :String
    var signatureMove :String
    var homeTown :String
    var wins :Double
    var losses :Double
    var winStreak :Double
    var totalGames :Double
    
    init(email :String, password :String, name :String, avatarURL :String, catchPrase :String, paddleGripStyle :String, signatureMove :String, homeTown :String, wins :Double, losses :Double, winStreak :Double, totalGames :Double){
        
        self.email = email
        self.password = password
        self.name = name
        self.avatarURL = avatarURL
        self.catchPrase = catchPrase
        self.paddleGripStyle = paddleGripStyle
        self.signatureMove = signatureMove
        self.homeTown = homeTown
        self.wins = wins
        self.losses = losses
        self.winStreak = winStreak
        self.totalGames = totalGames
    }
    
    
    
}
