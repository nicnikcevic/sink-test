//
//  Game.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import FirebaseFirestore
import SwiftUI

// A struct to represent an individual game of pong played
struct Game: Identifiable, Codable, Equatable, Hashable {
    @DocumentID var id: String?
    // The owner of the games username, ID and profile URL
    var userName: String
    var userUID: String
    var userProfileURL: URL

    //information of the owner's teamate
    var userName2: String
    var userUID2: String?
    var userProfileURL2: URL?

    //opponent 1
    var userName3: String
    var userUID3: String?
    var userProfileURL3: URL?

    //opponent 2
    var userName4: String
    var userUID4: String?
    var userProfileURL4: URL?

    // postive is team 1 won, negative is team 2 won
    // |cups| is the number of cups left on the table of
    // the winning team, representing the severity of the victory
    // users _ and 1 are team 1, user 3 and 4 are team 2
    var cups: Double

    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var dislikedIDs: [String] = []
    var gameRecap: String

    /* The type of game played, depending on the number of
    cups used. The two most popular game types are "shrub": 11 cups
     and "tree" 11 cups
    */
    var type: String

    // Tags to decode the struct into a .json file
    enum CodingKeys: CodingKey {
        case userName
        case userUID
        case userProfileURL
        case userName2
        case userUID2
        case userProfileURL2
        case userName3
        case userUID3
        case userProfileURL3
        case userName4
        case userUID4
        case userProfileURL4
        case cups
        case publishedDate
        case likedIDs
        case dislikedIDs
        case gameRecap
        case type
    }
}

