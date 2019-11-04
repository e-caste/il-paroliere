//
//  ContentView.swift
//  Il Paroliere
//
//  Created by Enrico Castelli on 04/11/2019.
//  Copyright © 2019 Enrico Castelli. All rights reserved.
//

import SwiftUI

struct ContentView: View
{
    // copied from the physical Paroliere 4x4 dice
    let diceLetters = [
        ["L","E","P","U","S","T"],
        ["O","E","U","N","C","T"],
        ["O","Qu","A","M","O","B"],
        ["R","I","F","O","A","C"],
        ["O","S","A","I","M","R"],
        ["V","I","T","E","N","G"],
        ["E","R","A","L","S","C"],
        ["L","R","O","E","I","U"],
        ["A","M","E","D","C","P"],
        ["D","A","N","E","Z","V"],
        ["I","R","E","N","H","S"],
        ["T","E","S","O","N","D"],
        ["T","L","R","B","I","A"],
        ["E","E","I","S","H","F"],
        ["O","I","A","A","T","E"],
        ["N","U","L","E","G","O"]
    ]
    
    // initialized stateful variable
    @State var shuffledDiceLetters = ["A","B","C","D","E","F","G","H","I","L","M","N","O","P","Q","R"]
    @State var diceOpacity = 0.01
    @State var timeRemaining = 0
    @State var timer = Timer.publish(every: TimeInterval(MAXFLOAT), on: .main, in: .common).autoconnect() // so that you don't see an alert on startup
    @State private var showingAlert = false
    
    func shuffleDiceLetters() -> [String] {
        var shuffledDiceLetters = [String]()
        for die in diceLetters.shuffled() {
            shuffledDiceLetters.append(die.randomElement()!)
        }
        // cover dice so they can't be seen until the game begins
        self.setDiceOpacity(opacityValue: 0.01)
        // stop timer
        self.timer = Timer.publish(every: TimeInterval(MAXFLOAT), on: .main, in: .common).autoconnect()
        return shuffledDiceLetters
    }
    
    // TODO: disable screen auto-lock
    // TODO: disable screen auto-rotate
    var body: some View {
        VStack {
            Text("Il Paroliere")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top)
            
            GeometryReader {
                geometry in
                self.useProxy(geometry)
            }
            .padding()
            .opacity(diceOpacity)
            
            Text("".appendingFormat("%02d:%02d",
                                            timeRemaining / 60,
                                            timeRemaining % 60))
                .font(.largeTitle)
                .fontWeight(.bold)
                .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                    else {
                        self.showingAlert = true
                        self.timer = Timer.publish(every: TimeInterval(MAXFLOAT), on: .main, in: .common).autoconnect()
               }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Timer scaduto"), message: Text("Giù le penne!"), dismissButton: .default(Text("OK Capo")))
            }
            
            Button(action: {
                self.shuffledDiceLetters = self.shuffleDiceLetters()
            }){
                HStack {
                    Image(systemName: "arrow.clockwise.circle")
                    Text("Mischia i dadi")
                }
            }
            .padding()
            
            Button(action: {
                self.startTimerAndUnveilDice()
            }){
                HStack {
                    Image(systemName: "hourglass")
                    Text("Scopri i dadi e gira la clessidra")
                }
            }
            .padding(.bottom, 32.0)
        }
        .onAppear(perform: {
                        self.shuffledDiceLetters = self.shuffleDiceLetters()
                    })
    
    }
    
    func startTimerAndUnveilDice() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.setTimeRemaining(timeInSeconds: 180)
        self.setDiceOpacity(opacityValue: 1.0)
    }
    
    func setDiceOpacity(opacityValue: Double) -> Void {
        self.diceOpacity = opacityValue
    }
    
    func setTimeRemaining(timeInSeconds: Int) -> Void {
        self.timeRemaining = timeInSeconds
    }
    
    func useProxy(_ geometry: GeometryProxy) -> some View {
        let dimension = min(geometry.size.width, geometry.size.height)
        return VStack {
            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[0])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[1])
                    .font(.largeTitle)
                    .fontWeight(.black)
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[2])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
                
                Text(self.shuffledDiceLetters[3])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
            }

            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[4])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[5])
                    .font(.largeTitle)
                    .fontWeight(.black)
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[6])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
                
                Text(self.shuffledDiceLetters[7])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
            }
            
            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[8])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[9])
                    .font(.largeTitle)
                    .fontWeight(.black)
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[10])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
                
                Text(self.shuffledDiceLetters[11])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
            }
            
            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[12])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[13])
                    .font(.largeTitle)
                    .fontWeight(.black)
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[14])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
                
                Text(self.shuffledDiceLetters[15])
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
