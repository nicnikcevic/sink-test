//
//  GameType.swift
//  SinkApp
//
//  Created by Frankie Severino on 1/11/25.
//

import SwiftUI

struct ShrubOrTreeView: View {
    @State private var selection: String? = nil

    var body: some View {
        VStack {
            Text("Shrub or Tree?")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .padding(70)

            Spacer() // Pushes the buttons downward slightly

            HStack(spacing: 60) {
                Button(action: {
                    selection = "Shrub"
                }) {
                    VStack {
                        Image("shrub1")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 100, height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        Text("SHRUB (7 cups)")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    selection = "Tree"
                }) {
                    VStack {
                        Image("tree1")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 100, height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        Text("TREE (11 cups)")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }

            if selection != nil {
                NavigationLink(destination: PlayingWithView()) {
                    Text("Next")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20) // Adds space above the "Next" button
            }

            Spacer(minLength: 50) // Push content down slightly without reaching too low
        }
        .padding()
    }
}

struct ShrubOrTreeView_Previews: PreviewProvider {
    static var previews: some View {
        ShrubOrTreeView()
    }
}
