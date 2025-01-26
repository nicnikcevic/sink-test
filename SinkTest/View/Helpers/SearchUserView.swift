//
//  SearchUserView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import FirebaseFirestore
import SwiftUI

struct SearchUserView: View {
    /// Properties to manage the view's state
    @State private var fetchedUsers: [User] = []  // Stores the list of users fetched from the database
    @State private var searchText: String = ""  // Stores the current search query
    @Environment(\.dismiss) private var dismiss  // Allows dismissing the view when needed

    var body: some View {
        // A list displaying fetched users
        List {
            // Iterates over the fetched users and creates a navigation link for each user
            ForEach(fetchedUsers) { user in
                NavigationLink {
                    // Navigates to the profile view for the selected user
                    ReusableProfileContent(user: user)
                } label: {
                    // Displays the username in the list
                    Text(user.username)
                        .font(.callout)
                        .hAlign(.leading)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)  // Displays the navigation bar title inline
        .navigationTitle("Search User")
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            // Fetches users when the search action is submitted
            Task { await searchUsers() }
        }
        .onChange(of: searchText) { newValue in
            // Clears the fetched users when the search text is emptied
            if newValue.isEmpty {
                fetchedUsers = []
            }
        }
    }

    /// Function to perform the user search using Firestore
    func searchUsers() async {
        do {
            // Executes a query in Firestore to fetch users whose usernames match the search text
            let documents = try await Firestore.firestore().collection("Users")
                .whereField("username", isGreaterThanOrEqualTo: searchText)  // Matches usernames starting with `searchText`
                .whereField(
                    "username", isLessThanOrEqualTo: "\(searchText)\u{f8ff}"
                )  // Matches usernames that are lexically similar
                .limit(to: 10)  // Limits the results to 10 users
                .getDocuments()

            // Converts Firestore documents to `User` objects
            let users = try documents.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)  // Decodes each document as a `User` object
            }

            // Updates the UI on the main thread with the fetched users
            await MainActor.run {
                fetchedUsers = users
            }
        } catch {
            // Handles errors by printing the error message
            print(error.localizedDescription)
        }
    }
}

// A preview for the `SearchUserView`, allowing developers to see how it looks in Xcode
struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView()  // Displays the view in the preview
    }
}
