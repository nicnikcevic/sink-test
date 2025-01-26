//
//  User.swift
//  SinkTest
//
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025

import FirebaseFirestore
import SwiftUI

// A struct to represent an idnividual user of the app
struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var userBio: String
    var userBioLink: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL

    // Tags to decode the struct into a .json file
    enum CodingKeys: CodingKey {
        case id
        case username
        case userBio
        case userBioLink
        case userUID
        case userEmail
        case userProfileURL
    }
}

