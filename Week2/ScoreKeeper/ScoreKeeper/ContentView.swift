//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Joon on 3/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var newPlayer: String = ""
    @State private var players: [Player] = [
        Player(name: "Asher", score: 0),
        Player(name: "Joon", score: 0),
        Player(name: "Nessa", score: 0)
    ]
    
    var body: some View {
        VStack {
            ForEach($players) { $player in
                TextField("Name", text: $player.name)
                Stepper("\(player.score)", value: $player.score)
            }
            
            Button("Add Player", systemImage: "plus.circle.fill") {
                players.append(Player(name: newPlayer, score: 0))
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
