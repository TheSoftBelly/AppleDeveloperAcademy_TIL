//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Joon on 3/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var newPlayer: String = ""
    @State private var scoreBoard = Scoreboard()
//    @State private var players: [Player] = [
//        Player(name: "Asher", score: 0),
//        Player(name: "Joon", score: 0),
//        Player(name: "Nessa", score: 0)
//    ]
    
    @State private var startingPoints = 0
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Score Keeper")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                SettingsView(startingPoints: $startingPoints)


                Grid {
                    GridRow {
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        Text("Score")
                    }
                    .font(.headline)


                    ForEach($scoreBoard.players) { $player in
                        GridRow {
                            TextField("Name", text: $player.name)
                            Text("\(player.score)")
                            Stepper("\(player.score)", value: $player.score)
                                .labelsHidden()
                        }
                    }
                }
                .padding(.vertical)


                Button("Add Player", systemImage: "plus") {
                    scoreBoard.players.append(Player(name: "", score: 0))
                }


                Spacer()
                
                switch scoreBoard.state {
                case .setup : Button("Start Game", systemImage: "play.fill"){
                    scoreBoard.state = .playing
                    scoreBoard.resetScores(to: startingPoints)
                }
                case .playing : Button("End Game", systemImage: "arrow.2.circlepath.circle"){
                    scoreBoard.state = .gameOver
                }
                case .gameOver : Button("Play Again", systemImage: "arrow.2.circlepath.circle") {
                    scoreBoard.state = .setup
                }
                }
            }
            .padding()
        }
    }


    #Preview {
        ContentView()
    }
