//
//  PlayingWith.swift
//  SinkApp
//
//  Created by Frankie Severino on 1/11/25.
//

import SwiftUI

struct PlayingWithView: View {
    @State private var teammate: String = ""
    @State private var opponent1: String = ""
    @State private var opponent2: String = ""

    var body: some View {
        VStack(spacing: 40) {
            Text("Who are you playing with?")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
            

            TextField("Teammate", text: $teammate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Opponent 1", text: $opponent1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Opponent 2", text: $opponent2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            NavigationLink(destination: TimerView()) {
                Text("Start Timer")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct PlayingWithView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingWithView()
    }
}
