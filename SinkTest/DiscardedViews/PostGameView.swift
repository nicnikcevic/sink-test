//
//  PostGameView.swift
//  SinkApp
//
//  Created by Frankie Severino on 1/11/25.
//

import SwiftUI

struct PostGameView: View {
    @State private var didWin: Bool? = nil
    @State private var cupsLeft: Int = 0
    let maxCups: Int = 22

    var body: some View {
        VStack(spacing: 120) {
            Text("Did you win?")
                .font(.system(size: 40, weight: .semibold, design: .rounded))

            HStack(spacing: 30) {
                Button(action: {
                    didWin = true
                }) {
                    Text("Yes")
                        .font(.title)
                        .frame(width: 120, height: 500)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    didWin = false
                }) {
                    Text("No")
                        .font(.title)
                        .frame(width: 120, height: 500)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            if didWin != nil {
                VStack(spacing: 20) {
                    Text("Winner's cups left?")
                        .font(.title2)

                    HStack {
                        Button(action: {
                            if cupsLeft > 0 {
                                cupsLeft -= 1
                            }
                        }) {
                            Text("-")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }

                        Text("\(cupsLeft)")
                            .font(.title)
                            .frame(width: 100)

                        Button(action: {
                            if cupsLeft < maxCups {
                                cupsLeft += 1
                            }
                        }) {
                            Text("+")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                    }

                    // Add a final navigation or action if necessary
                }
            }
        }
        .padding()
    }
}

struct PostGameView_Previews: PreviewProvider {
    static var previews: some View {
        PostGameView()
    }
}
