//
//  GamesView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import SwiftUI

// A SwiftUI View representing the main Games screen in the application
struct GamesView: View {
    // State variable to hold an array of recent games, initialized as empty
    // @State allows the view to update when this array changes
    @State var recentsGames: [Game] = []

    // Private state variable to control the presentation of the game creation modal
    @State private var createNewGame: Bool = false

    var body: some View {
        // NavigationStack provides a container for hierarchical navigation
        NavigationStack {
            // Reusable view to display the list of games
            // Uses a binding to allow the view to modify the recentsGames array
            ReusableGamesView(games: $recentsGames)
                // Align the content to the center of the screen
                .hAlign(.center).vAlign(.center)
            
                .overlay(alignment: .bottomTrailing) {
                }
                // Configure the navigation bar items
                .toolbar(content: {
                    // Add a search button in the top-right of the navigation bar
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        // Navigation link to the SearchUserView
                        NavigationLink {
                            SearchUserView()
                        } label: {
                            // Magnifying glass icon for search
                            Image(systemName: "magnifyingglass")
                                .tint(.black)
                                .scaleEffect(0.9)
                        }
                    }
                })
                // Set the title of the navigation bar
                .navigationTitle("Games")
        }
        
        
        .fullScreenCover(isPresented: $createNewGame) {
            // CreateNewGame view with a closure to handle the newly created game
            CreateNewGame { game in
                /// - Adding Created game at the Top of the Recent Games
                // Insert the newly created game at the beginning of the recentsGames array
                recentsGames.insert(game, at: 0)
            }
        }
    }
}
