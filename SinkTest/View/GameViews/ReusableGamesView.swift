//
//  ReusableGamesView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import Firebase
import FirebaseFirestore
import SwiftUI

struct ReusableGamesView: View {
    //For a profile, only games that a user has participated in are included
    //Thus the displaying of them is based of a UID
    var basedOnUID: Bool = false
    var uid: String = ""
    var userN: String = ""
    @Binding var games: [Game]
    @State private var isFetching: Bool = true
    @State private var paginationDoc: QueryDocumentSnapshot?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 10) {
                if isFetching {
                    ProgressView()
                        .padding(.top, 30)
                        .id("loading-indicator")  // Unique ID for progress view
                } else {
                    if games.isEmpty {
                        Text("No Game's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                            .id("empty-message")  // Unique ID for empty state
                    } else {
                        Games()
                    }
                }
            }
            .padding(15)
        }
        .refreshable {
            guard !basedOnUID else { return }
            isFetching = true
            games = []
            paginationDoc = nil
            await fetchGames()
        }
        .task {
            guard games.isEmpty else { return }
            await fetchGames()
        }
    }

    @ViewBuilder
    // Iterate through all the fetched games
    func Games() -> some View {
        ForEach(games.indices, id: \.self) { index in
            let game = games[index]

            // Each game item wrapped in a unique identifier container
            VStack(spacing: 0) {
                GameCardView(game: game) { updatedGame in
                    if let updateIndex = games.firstIndex(where: {
                        $0.id == updatedGame.id
                    }) {
                        games[updateIndex].likedIDs = updatedGame.likedIDs
                    }
                } onDelete: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        games.removeAll(where: { $0.id == game.id })
                    }
                }

                if index != games.count - 1 {
                    Divider()
                        .padding(.horizontal, -15)
                        .id("divider-\(game.id ?? UUID().uuidString)")
                }
            }
            .id("container-\(game.id ?? UUID().uuidString)-\(index)")
            .onAppear {
                if index == games.count - 1 && paginationDoc != nil {
                    Task { await fetchGames() }
                }
            }
        }
    }

    // Modify fetchGames to ensure IDs are always present
    func fetchGames() async {
        do {
            var query: Query!

            // Base query setup
            let baseQuery = Firestore.firestore().collection("Games")
                .order(by: "publishedDate", descending: true)
                .limit(to: 20)

            if let paginationDoc {
                query = baseQuery.start(afterDocument: paginationDoc)
            } else {
                query = baseQuery
            }

            // Only do username queries if basedOnUID is true
            if basedOnUID {
                // Create compound queries for each username field
                /* If any of the usernames associate with the game match the
                 username of the user, display that game in their profile
                 */
                async let docs1 = query.whereField("userName", isEqualTo: userN)
                    .getDocuments()
                async let docs2 = query.whereField(
                    "userName2", isEqualTo: userN
                ).getDocuments()
                async let docs3 = query.whereField(
                    "userName3", isEqualTo: userN
                ).getDocuments()
                async let docs4 = query.whereField(
                    "userName4", isEqualTo: userN
                ).getDocuments()

                let allDocs = try await [docs1, docs2, docs3, docs4]

                // Combine and process results
                let allGames = allDocs.flatMap { querySnapshot in
                    querySnapshot.documents.compactMap { doc -> Game? in
                        var game = try? doc.data(as: Game.self)
                        game?.id = doc.documentID
                        return game
                    }
                }

                // Remove duplicates and sort
                let uniqueGames = Array(Set(allGames))
                let sortedGames = uniqueGames.sorted {
                    ($0.publishedDate ?? Date()) > ($1.publishedDate ?? Date())
                }

                await MainActor.run(body: {
                    games.append(contentsOf: sortedGames)
                    // Get the last document from our sorted results
                    paginationDoc = sortedGames.last?.id.flatMap { lastID in
                        allDocs.flatMap { $0.documents }.first {
                            $0.documentID == lastID
                        }
                    }
                    isFetching = false
                })
            } else {
                // Regular query for all games
                let docs = try await query.getDocuments()
                let fetchedGames = docs.documents.compactMap { doc -> Game? in
                    var game = try? doc.data(as: Game.self)
                    game?.id = doc.documentID
                    return game

                }

                await MainActor.run(body: {
                    games.append(contentsOf: fetchedGames)
                    paginationDoc = docs.documents.last
                    isFetching = false
                })
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ReusableGamesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
