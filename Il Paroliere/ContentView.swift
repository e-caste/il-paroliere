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
    let diceLetters: [[String]] = [
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
    
    let possibleRotations: [Double] = [0.0, 90.0, 180.0, 270.0] // 360.0 == 0.0 -- 0.0=N, 90.0=E=RX, 180.0=S, 270.0=W=LX
    
    // initialized stateful variable
    @State var shuffledDiceLettersAndRotations = [TextShuffledAndRotated](
        repeating: TextShuffledAndRotated(text: "A", rotation: 0.0), count: 16
    )
    @State var diceOpacity = 0.01
    @State var timeRemaining = 0
    @State var timer = Timer.publish(every: TimeInterval(MAXFLOAT), on: .main, in: .common).autoconnect() // so that you don't see an alert on startup
    @State private var showingAlert = false
    @State private var rulesArePresented = false
    
    class TextShuffledAndRotated {
        var id = UUID() // needed to satisfy Hashable requirement
        var text: String
        var rotation: Double
        init(text: String, rotation:Double) {
            self.text = text
            self.rotation = rotation
        }
    }
    
    func shuffleDiceLettersAndRotations() -> [TextShuffledAndRotated] {
        var shuffledDiceLetters = [String]()
        // shuffle dice letters and positions
        for die in diceLetters.shuffled() {
            shuffledDiceLetters.append(die.randomElement()!)
        }
        // cover dice so they can't be seen until the game begins
        self.setDiceOpacity(opacityValue: 0.01)
        // stop timer
        self.timer = Timer.publish(every: TimeInterval(MAXFLOAT), on: .main, in: .common).autoconnect()
        // make a list of 16 rotations extracted from possibleRotations
        var rotations = [Double]()
        // shuffle dice rotations
        for _ in 0...15 {
            rotations.append(possibleRotations.randomElement()!)
        }
        var shuffledDiceLettersAndRotations = [TextShuffledAndRotated]()
        for (letter, rotation) in zip(shuffledDiceLetters, rotations) {
            shuffledDiceLettersAndRotations.append(TextShuffledAndRotated(text: letter, rotation: rotation))
        }
        return shuffledDiceLettersAndRotations
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Il Paroliere")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                    .padding([.top, .leading])
                
                Spacer()
                
                Button(action: {
                    self.rulesArePresented.toggle()
                }) { // Button to show the modal view by toggling the state
                    Text("Regole")
                        .multilineTextAlignment(.trailing)
                        .padding([.top, .trailing])
                }.sheet(isPresented: $rulesArePresented) { // Passing the state to the sheet API
                    Form {
                        Section(header: Text("Punteggi")){
                            Text("1-2 lettere: 0 punti\n3-4 lettere: 1 punto\n5 lettere: 2 punti\n6 lettere: 3 punti\n7 lettere: 5 punti\n8+ lettere: 11 punti")
                        }
                        Section(header: Text("Per iniziare")){
                            Text("Ogni giocatore ha bisogno di un metodo per segnarsi le parole che trova tra i dadi, sia esso carta e penna o una nota sul telefono. Il numero massimo di giocatori è determinato da quante persone riescono a leggere lo schermo contemporaneamente.")
                        }
                        Section(header: Text("Regole del gioco")){
                            Text("Si tocca il tasto 'Mischia i dadi', che simula lo scuotimento rumoroso dei dadi del Paroliere da tavolo e li copre. Quando tutti i giocatori sono pronti, si tocca il tasto 'Scopri i dadi e gira la clessidra' per far partire il timer da 3 minuti.\nLo scopo del gioco è trovare il maggior numero possibile di parole nel tempo dato composte da lettere adiacenti sia ortogonalmente che diagonalmente, senza far copiare gli avversari. È vietato comporre una parola saltando una lettera o ripassando sullo stessa lettera.\nUna volta terminato il tempo a disposizione, i giocatori devono smettere di scrivere e a turno ciascuno deve leggere le proprie parole: se una stessa parola è stata trovata da più giocatori, essi dovranno cancellarla dal proprio elenco. Se una parola è ritenuta non valida dagli altri giocatori, si può cercare su un dizionario per stabilirne la validità.")
                        }
                        Section(header: Text("Validità delle parole")){
                            Text("Sono ammesse le tipologie di parole determinate dal gruppo di giocatori. In generale, si possono usare le seguenti linee guida:\nsostantivi e aggettivi al maschile/femminile singolare/plurale, verbi all'infinito, avverbi, congiunzioni, interiezioni, onomatopee, preposizioni e pronomi sono sempre validi;\nverbi coniugati, sigle, parole straniere di uso comune in Italiano, nomi propri e geografici possono essere aggiunti per semplificare il gioco.")
                        }
                    }
                }
            }
            
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
                self.shuffledDiceLettersAndRotations = self.shuffleDiceLettersAndRotations()
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
                        self.shuffledDiceLettersAndRotations = self.shuffleDiceLettersAndRotations()
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

        // make 16 views for letters
//        return VStack {
//            ForEach(shuffledDiceLettersAndRotations, id: \.id){letterAndRotation in
//                HStack(spacing: 0) {
//                    Text(letterAndRotation.text)
//                    .font(.largeTitle)
//                    .fontWeight(.black)
//                    .frame(width: dimension / 4, height: dimension / 4) // TODO: replace with area
//                    .border(Color.black) // TODO: change to system color
//                    .rotationEffect(.degrees(letterAndRotation.rotation))
//                }
//            }
//        }
        
        return VStack {
            HStack(spacing: 0) {
                Text(self.shuffledDiceLettersAndRotations[0].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[0].rotation))

                Text(self.shuffledDiceLettersAndRotations[1].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[1].rotation))

                Text(self.shuffledDiceLettersAndRotations[2].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[2].rotation))

                Text(self.shuffledDiceLettersAndRotations[3].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[3].rotation))
            }

            HStack(spacing: 0) {
                Text(self.shuffledDiceLettersAndRotations[4].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[4].rotation))

                Text(self.shuffledDiceLettersAndRotations[5].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[5].rotation))

                Text(self.shuffledDiceLettersAndRotations[6].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[6].rotation))

                Text(self.shuffledDiceLettersAndRotations[7].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[7].rotation))
            }

            HStack(spacing: 0) {
                Text(self.shuffledDiceLettersAndRotations[8].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[8].rotation))

                Text(self.shuffledDiceLettersAndRotations[9].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[9].rotation))

                Text(self.shuffledDiceLettersAndRotations[10].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[10].rotation))

                Text(self.shuffledDiceLettersAndRotations[11].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[11].rotation))
            }

            HStack(spacing: 0) {
                Text(self.shuffledDiceLettersAndRotations[12].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[12].rotation))

                Text(self.shuffledDiceLettersAndRotations[13].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[13].rotation))

                Text(self.shuffledDiceLettersAndRotations[14].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[14].rotation))

                Text(self.shuffledDiceLettersAndRotations[15].text)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: dimension / 4, height: dimension / 4)
                    .rotationEffect(.degrees(self.shuffledDiceLettersAndRotations[15].rotation))
            }
        }  // end of VStack
    }
}

//struct TextShuffledAndRotatedStyle: ViewModifier {
//    typealias Body = <#type#>
//
//    func body(content: Content, dimension: CGFloat, rotation: Double) -> some View {
//        content
//            .font(.largeTitle)
////            .fontWeight(.black)
//            .frame(width: dimension / 4, height: dimension / 4)
//            .border(Color.black)
//            .rotationEffect(.degrees(rotation))
//    }
//}

// .border(Color.black) -- removed since I don't want a border around the letters

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
