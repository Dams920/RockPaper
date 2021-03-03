//
//  ContentView.swift
//  RockPaper
//
//  Created by Damien Chailloleau on 03/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var playerChoice = "✋"
    @State private var botChoice = Int.random(in: 0 ..< 3)
    @State private var scores = [0, 0, 0]
    @State private var showScore = false
    @State private var numberRounds = 10
    @State private var winnerIs = ""
    
    var moves = ["👊", "✋", "✌️"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("👨 Player: \(scores[0])")
                        .padding(10)
                        .foregroundColor(.white)
                        .font(.title2)
                    Text("🤝 Draw: \(scores[1])")
                        .padding(10)
                        .foregroundColor(.white)
                        .font(.title2)
                    Text("🤖 Bot: \(scores[2])")
                        .padding(10)
                        .foregroundColor(.white)
                        .font(.title2)
                }
                HStack {
                    Text("Rounds Left: \(numberRounds)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .italic()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("IA : \(moves[botChoice])")
                        .padding(.bottom)
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text("Player : \(playerChoice)")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                HStack {
                    ForEach(0 ..< moves.count) { number in
                        Button(action: {
                            playerMove(number)
                            numberRounds -= 1
                            showAlert()
                        }) {
                            MovesView(choice: "\(self.moves[number])")
                        }
                    }
                }
            }
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text("Result of the Game"), message: Text("This is \(winnerIs) for that game"), dismissButton: .default(Text("Continue")) {
                self.restartGame()
            })
        }
    }
    
    func playerMove(_ number: Int) {
        playerChoice = "\(moves[number])"
        botChoice = Int.random(in: 0 ..< moves.count)
        if (playerChoice == moves[1] && moves[botChoice] == moves[0]) ||
            (playerChoice == moves[2] && moves[botChoice] == moves[1]) ||
            (playerChoice == moves[0] && moves[botChoice] == moves[2]) {
            scores[0] += 1
        } else if (moves[botChoice] == moves[1] && playerChoice == moves[0]) ||
                    (moves[botChoice] == moves[2] && playerChoice == moves[1]) ||
                    (moves[botChoice] == moves[0] && playerChoice == moves[2]) {
            scores[2] += 1
        } else if playerChoice == moves[botChoice] {
            scores[1] += 1
        }
    }
    
    func showResult() {
        if scores[0] > scores[2] && scores[0] > scores[1] {
            winnerIs = "the Player who won"
        } else if scores[2] > scores[0] && scores[2] > scores[1] {
            winnerIs = "the Bot who won"
        } else if scores[1] > scores[0] && scores[1] > scores[2] {
            winnerIs = "a Draw"
        }
    }
    
    func showAlert() {
        if numberRounds == 0 {
            showScore = true
        }
        showResult()
    }
    
    func restartGame() {
        scores = [0, 0, 0]
        numberRounds = 10
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
