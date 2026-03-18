//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Joon on 3/18/26.
//

import Foundation

struct Scoreboard {
    var players: [Player] = [
        Player(name: "Joon", score: 0),
        Player(name: "Asher", score: 0),
        Player(name: "Nessa", score: 0),
    ]
    
    var state = GameState.setup
    
    mutating func resetScores(to newValue: Int){
        for index in 0..<players.count{
            players[index].score = newValue
        }
    }
}
