//
//  User.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import Foundation

class User {
    
    var email :String?
    var password :String?
    var nickName: String?
    var createdAt: Date?
    var avatarURL: String?
    
    var wins: Double?
    var losses: Double?
    var winStreak: Double?
    var winRatio: Double?
    var totalGames: Double?
    
    var catchPhrase: String?
    var paddleGripStyle: String?
    var signatureMove: String?
    var homeTown: String?
    
    var id :String?
    
    init(id : String, nickName : String, score :Double, losses : Double,  winStreak : Double ,  winRatio:Double , totalGames : Double, avatarURL : String,catchPhrase : String, paddleGripStyle:String, signatureMove :String, homeTown : String  ) {
        
        self.id = id
        self.nickName = nickName
        self.wins = score
        self.losses = losses
        self.winStreak = winStreak
        self.winRatio = winRatio
        self.totalGames = totalGames
        self.avatarURL = avatarURL
        self.catchPhrase = catchPhrase
        self.paddleGripStyle = paddleGripStyle
        self.signatureMove = signatureMove
        self.homeTown = homeTown
        
        
    }
    
    init() {}
    



}
