//
//  GameCardView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImageSwiftUI
import SwiftUI

struct GameCardView: View {
    var game: Game

    /* A list of verbs which can describe the outcome of a game
     ie "x and y CRUSHED w and z"
     */
    var verbs: [String] = [
        "HALFED", "DEFEATED", "DEFEATED", "BEAT", "BEAT", "BEAT", "CRUSHED",
        "CRUSHED", "CRUSHED", "DESTROYED", "DESTROYED", "TREED",
    ]

    /// - Callbacks
    var onUpdate: (Game) -> Void
    var onDelete: () -> Void
    /// - View Properties
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListner: ListenerRegistration?

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                if game.cups > 0 {  //if the cup value is greater than 0, the owner of the game won
                    //Display the owner and their partner on the left side of the screen
                    HStack {
                        if game.userProfileURL != nil {
                            WebImage(url: game.userProfileURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        }
                        Text(game.userName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18, weight: .regular))
                    }
                    Spacer()
                    HStack {
                        if game.userProfileURL2 != nil {
                            WebImage(url: game.userProfileURL2)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                        Text(game.userName2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .font(.system(size: 18, weight: .regular))
                    }
                }

                if game.cups < 0 {  //The user lost, display The opponents (userName3 and userName4) on the left side of the card
                    HStack {
                        if game.userProfileURL3 != nil {
                            WebImage(url: game.userProfileURL3)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        }
                        Text(game.userName3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 18, weight: .regular))
                    }
                    Spacer()
                    HStack {
                        if game.userProfileURL4 != nil {
                            WebImage(url: game.userProfileURL4)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                        Text(game.userName4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                            .font(.system(size: 18, weight: .regular))
                    }
                }
            }

            .frame(maxWidth: .infinity)  // Align to the left
            VStack {
                Text(
                    "\(game.publishedDate.formatted(date: .numeric, time: .shortened))"
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 10, weight: .light))
                Spacer()
                Text("\(verbs[Int(abs(game.cups))])")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 22, weight: .heavy))
                Spacer()
                Text("\(String(format: "%.1f", abs(game.cups)))")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 12)
                    .font(.system(size: 12, weight: .regular))
            }

            .frame(maxWidth: .infinity)  // Take up 1/3 of horizontal space
            VStack {
                if game.cups > 0 {
                    HStack {
                        Text(game.userName3)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 18, weight: .regular))
                        if game.userProfileURL4 != nil {
                            WebImage(url: game.userProfileURL3)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                    HStack {
                        Text(game.userName4)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 10)
                            .font(.system(size: 18, weight: .regular))
                        if game.userProfileURL4 != nil {
                            WebImage(url: game.userProfileURL4)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                    }
                }
                if game.cups < 0 {
                    HStack {
                        Text(game.userName)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 18, weight: .regular))
                        if game.userProfileURL4 != nil {
                            WebImage(url: game.userProfileURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                    HStack {
                        Text(game.userName2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 10)
                            .font(.system(size: 18, weight: .regular))
                        if game.userProfileURL4 != nil {
                            WebImage(url: game.userProfileURL2)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image("NullProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 18, height: 18)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                    }
                }
            }

            .frame(maxWidth: .infinity)  // Take up 1/3 of horizontal space

        }
        .frame(maxWidth: .infinity)  // Take up 1/3 of horizontal space
    }

    // To be built out
    // Managing Liking and disliking a game
    //    @ViewBuilder
    //    func GameInteraction() -> some View {
    //        HStack(spacing: 6) {
    //            Button(action: likeGame) {
    //                Image(
    //                    systemName: game.likedIDs.contains(userUID)
    //                        ? "hand.thumbsup.fill" : "hand.thumbsup")
    //            }
    //
    //            Text("\(game.likedIDs.count)")
    //                .font(.caption)
    //                .foregroundColor(.gray)
    //
    //            .padding(.leading, 25)
    //
    //        }
    //        .foregroundColor(.black)
    //        .padding(.vertical, 8)
    //    }
    //
    //    /// - Liking Game
    //    func likeGame() {
    //        Task {
    //            guard let gameID = game.id else { return }
    //            if game.likedIDs.contains(userUID) {
    //                /// Removing User ID From the Array
    //                try await Firestore.firestore().collection("Games").document(
    //                    gameID
    //                ).updateData([
    //                    "likedIDs": FieldValue.arrayRemove([userUID])
    //                ])
    //            } else {
    //                /// Adding User ID To Liked Array and removing our ID from Disliked Array (if Added in prior)
    //                try await Firestore.firestore().collection("Games").document(
    //                    gameID
    //                ).updateData([
    //                    "likedIDs": FieldValue.arrayUnion([userUID])
    //                ])
    //            }
    //        }
    //    }
    //
    //    /// - Deleting Game
    //    func deleteGame() {
    //        Task {
    //            /// Step 1: Delete Image from Firebase Storage if present
    //            do {
    //                //                if game.imageReferenceID != ""{
    //                //                    try await Storage.storage().reference().child("Game_Images").child(game.imageReferenceID).delete()
    //                //                }
    //                /// Step 2: Delete Firestore Document
    //                guard let gameID = game.id else { return }
    //                try await Firestore.firestore().collection("Games").document(
    //                    gameID
    //                ).delete()
    //            } catch {
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    //}

}
