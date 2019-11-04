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
    
    var body: some View
    {
        GeometryReader
        { geometry in
            self.useProxy(geometry)
        }
    }

    func useProxy(_ geometry: GeometryProxy) -> some View
    {
        let dimension = min(geometry.size.width, geometry.size.height)
        let shuffledDiceLetters = shuffleDiceLetters()
        return VStack
        {
            HStack(spacing: 0)
            {
                Text(shuffledDiceLetters[0])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(shuffledDiceLetters[1])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(shuffledDiceLetters[2])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(shuffledDiceLetters[3])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }

            HStack(spacing: 0)
            {
                Text(shuffledDiceLetters[4])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(shuffledDiceLetters[5])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(shuffledDiceLetters[6])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(shuffledDiceLetters[7])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
            
            HStack(spacing: 0)
            {
                Text(shuffledDiceLetters[8])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(shuffledDiceLetters[9])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(shuffledDiceLetters[10])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(shuffledDiceLetters[11])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
            
            HStack(spacing: 0)
            {
                Text(shuffledDiceLetters[12])
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text(shuffledDiceLetters[13])
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text(shuffledDiceLetters[14])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text(shuffledDiceLetters[15])
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
        }
    }
    
    func shuffleDiceLetters() -> [String] {
        var shuffledDiceLetters = [String]()
        for die in diceLetters.shuffled() {
            shuffledDiceLetters.append(die.randomElement()!)
        }
        return shuffledDiceLetters
    }
}

//struct ContentView: View {
//    var body: some View {
//        Text("Hello World")
////        Array(repeating: [0,0,0,0], count: 4)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



