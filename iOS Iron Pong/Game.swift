//
//  Game.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import Foundation

class Game {
    
    var playerOne :String
    var playerTwo :String
    var winner :String
    var loser :String
    var playerOneScore :Double
    var playerTwoScore :Double
    
    init(playerOne :String, playerTwo :String, winner :String, loser :String, playerOneScore :Double, playerTwoScore :Double) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.winner = winner
        self.loser = loser
        self.playerOneScore = playerOneScore
        self.playerTwoScore = playerTwoScore
    }
    
}
