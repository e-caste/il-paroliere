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
        return VStack
        {
            HStack(spacing: 0)
            {
                Text("Top Left")
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text("Top Right")
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }

            HStack(spacing: 0)
            {
                Text("Bottom Left")
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text("Bottom Right")
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
            
            HStack(spacing: 0)
            {
                Text("Bottom Left")
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text("Bottom Right")
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
            
            HStack(spacing: 0)
            {
                Text("Bottom Left")
                    .frame(width: dimension / 4, height: dimension / 4)
                    .border(Color.black)

                Text("Bottom Right")
                   .frame(width: dimension / 4, height: dimension / 4)
                   .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
                
                Text("Top Right")
                .frame(width: dimension / 4, height: dimension / 4)
                .border(Color.black)
            }
        }
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



