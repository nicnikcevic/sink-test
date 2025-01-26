//
//  ReusableProfilecontent.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import SDWebImageSwiftUI
import SwiftUI

struct ReusableProfileContent: View {
    var username: String = ""
    var user: User

    @State private var fetchedGames: [Game] = []
    var body: some View {
        HStack(spacing: 12) {
            if user.userProfileURL != nil {
                WebImage(url: user.userProfileURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            } else {
                Image("NullProfile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(user.username)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(user.userBio)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(3)

                // MARK: Displaying Bio Link, If Given While Signing Up Profile Page
                if let bioLink = URL(string: user.userBioLink) {
                    Link(user.userBioLink, destination: bioLink)
                        .font(.callout)
                        .tint(.blue)
                        .lineLimit(1)
                }
            }
            .hAlign(.leading)
        }
        .padding(15)
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                Divider()

                //ReusableGamesView(basedOnUID: true, uid: user.userUID, games: $fetchedGames)
                ReusableGamesView(
                    basedOnUID: true, uid: user.userUID, userN: user.username,
                    games: $fetchedGames)

            }
        }
    }
}
