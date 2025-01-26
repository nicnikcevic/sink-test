//
//  MainView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import SwiftUI

struct MainView: View {
    //A list of all the games played
    @State private var recentsGames: [Game] = []
    @State private var createNewGame: Bool = false

    var body: some View {
        ZStack {
            VStack {
                TopView()

                TabView {
                    GamesView()
                        .tabItem {
                            Label {
                                Text("Recent Games")
                            } icon: {
                                Image("recent games")
                                    .renderingMode(.template)
                            }
                        }

                    ProfileView()
                        .tabItem {
                            Label {
                                Text("Profile")
                            } icon: {
                                Image("profile")
                                    .renderingMode(.template)
                            }
                        }
                }
                .tint(Color.black)
            }

            // Floating Button
            VStack {
                Spacer()
                Button(action: {
                    createNewGame.toggle()
                }) {
                    Image("sink_icon_white_small")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(23)
                        .background(
                            Circle()
                                .fill(
                                    Color(
                                        red: 185 / 255, green: 15 / 255,
                                        blue: 20 / 255))
                        )
                        .shadow(
                            color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding(.bottom, 45)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .fullScreenCover(isPresented: $createNewGame) {
            CreateNewGame { game in
                recentsGames.insert(game, at: 0)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
