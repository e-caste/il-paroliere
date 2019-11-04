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
    
    func shuffleDiceLetters() -> [String] {
        var shuffledDiceLetters = [String]()
        for die in diceLetters.shuffled() {
            shuffledDiceLetters.append(die.randomElement()!)
        }
        // cover dice so they can't be seen until the game begins
        self.setDiceOpacity(opacityValue: 0.01)
        return shuffledDiceLetters
    }
    
    mutating func _shuffleDiceLetters() -> Void {
        self.shuffledDiceLetters.removeAll()
        for die in diceLetters.shuffled() {
            self.shuffledDiceLetters.append(die.randomElement()!)
        }
    }
    
    // TODO: add support for Dark Mode
    // TODO: tweak font
    // TODO: add timer
    // TODO: add alert when timer is finished
    // TODO: add veil on top of dice until timer starts
    var body: some View {
        VStack {
            Text("Il Paroliere")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .padding(.trailing)
            
            GeometryReader {
                geometry in
                self.useProxy(geometry)
            }
            .padding()
            .opacity(getDiceOpacity())
            
            // timer
            
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
            .padding()
        }
        .onAppear(perform: {
                        self.shuffledDiceLetters = self.shuffleDiceLetters()
                    })
    
    }
    
    func startTimerAndUnveilDice() {
        
        
        self.setDiceOpacity(opacityValue: 1.0)
    }
    
    func setDiceOpacity(opacityValue: Double) -> Void {
        self.diceOpacity = opacityValue
    }
    
    func getDiceOpacity() -> Double {
        return self.diceOpacity
    }
    
    func useProxy(_ geometry: GeometryProxy) -> some View {
        let dimension = min(geometry.size.width, geometry.size.height)
        return VStack {
            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[0])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[1])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[2])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(self.shuffledDiceLetters[3])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }

            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[4])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[5])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[6])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(self.shuffledDiceLetters[7])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
            
            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[8])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[9])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[10])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(self.shuffledDiceLetters[11])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
            
            HStack(spacing: 0) {
                Text(self.shuffledDiceLetters[12])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(self.shuffledDiceLetters[13])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(self.shuffledDiceLetters[14])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(self.shuffledDiceLetters[15])
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



