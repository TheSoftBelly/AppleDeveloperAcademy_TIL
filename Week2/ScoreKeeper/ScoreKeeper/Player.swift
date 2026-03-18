//
//  Player.swift
//  ScoreKeeper
//
//  Created by Joon on 3/18/26.
//

import Foundation

struct Player: Identifiable {
    let id=UUID()
    var name: String
    var score: Int = 0
}
