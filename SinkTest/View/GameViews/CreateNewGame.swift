//
//  CreateNewGame.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import SwiftUI

public struct CreateNewGame: View {
    // Callback to handle game creation
    var onGame: (Game) -> Void

    // Game input state variables
    @State var userName2: String = ""
    @State var userName3: String = ""
    @State var userName4: String = ""
    @State var type: String = ""
    @State var cupIn: String = ""
    @State var didWin: Bool = false
    @State var cups: Double = 0.0

    // User data from persistent storage
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""

    // View management properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool

    public var body: some View {
        VStack {
            // Navigation header with cancel and create buttons
            HStack {
                Menu {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                } label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .hAlign(.leading)

                // Create game button with validation
                Button(action: createGame) {
                    Text("Create Game")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(
                            Color(
                                red: 184 / 255, green: 15 / 255, blue: 10 / 255),
                            in: Capsule())
                }
                .disableWithOpacity(
                    type == "" || cups == 0.0 || userName2 == ""
                        || userName3 == "" || userName4 == "")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }

            // Game creation form
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    // Game type selection (Shrub or Tree)
                    HStack {
                        Button(action: { type = "Shrub" }) {
                            VStack {
                                Image("shrub1")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(width: 180, height: 180)
                                    .background(
                                        type == "Shrub"
                                            ? Color.black : Color.clear
                                    )
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                type == "Shrub"
                                                    ? Color.white : Color.black,
                                                lineWidth: 2)
                                    )
                                Text("Shrub (7 cups)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: { type = "Tree" }) {
                            VStack {
                                Image("tree1")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .frame(width: 180, height: 180)
                                    .background(
                                        type == "Tree"
                                            ? Color.black : Color.clear
                                    )
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                type == "Tree"
                                                    ? Color.white : Color.black,
                                                lineWidth: 2)
                                    )
                                Text("Tree (11 cups)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    //.padding(20)

                    // Win/Loss selection buttons
                    HStack(spacing: 20) {
                        Button(action: { didWin = true }) {
                            Text("I won!")
                                .font(.system(size: 32, weight: .black))
                                .frame(
                                    width: UIScreen.main.bounds.width * 0.425,
                                    height: 100
                                )
                                .background(
                                    didWin == true
                                        ? Color(
                                            red: 20 / 255, green: 165 / 255,
                                            blue: 20 / 255)
                                        : Color(red: 0.5, green: 1, blue: 0.5)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }

                        Button(action: { didWin = false }) {
                            Text("I lost.")
                                .font(.system(size: 32, weight: .black))
                                .frame(
                                    width: UIScreen.main.bounds.width * 0.425,
                                    height: 100
                                )
                                .background(
                                    didWin == false
                                        ? Color(
                                            red: 185 / 255, green: 15 / 255,
                                            blue: 20 / 255)
                                        : Color(red: 1, green: 0.5, blue: 0.5)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding()

                    // Player name input fields
                    TextField("Your Teammate", text: $userName2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Opponent 1", text: $userName3)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Opponent 2", text: $userName4)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    // Cup difference input with validation
                    TextField("Cups left on table", text: $cupIn)
                        .keyboardType(.decimalPad)
                        .onChange(of: cupIn) { newValue in
                            if let value = Double(newValue) {
                                // Validate cup input based on game type
                                if (type == "Tree" && value < 11)
                                    || (type == "Shrub" && value < -7)
                                    || (value <= 0)
                                {
                                    // This should be updated to be displayed to the user
                                    print("Invalid cup input")
                                }
                                
                                /* Game stores the cups variable as negative if the owner lost, and positive if the owner won */
                                if didWin {
                                    cups = value
                                } else {
                                    cups = -1 * value
                                }
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
    }

    // Create game and save to Firebase
    func createGame() {
        isLoading = true
        showKeyboard = false
        Task {
            do {
                guard let profileURL = profileURL else { return }

                // Generate game recap based on cup difference
                let recap: String
                if cups > 0 {
                    recap =
                        "\(userName) and \(userName2) beat \(userName3) and \(userName4) by \(cups) cups."
                } else if cups < 0 {
                    recap =
                        "\(userName3) and \(userName4) beat \(userName) and \(userName2) by \(-cups) cups."
                } else {
                    recap = "What the fuck this shouldn't be possible"
                }

                // Create game object
                let game = Game(
                    userName: userName,
                    userUID: userUID,
                    userProfileURL: profileURL,
                    userName2: userName2,
                    userName3: userName3,
                    userName4: userName4,
                    cups: cups,
                    gameRecap: recap,
                    type: type
                )

                // Save game to Firestore
                try await createDocumentAtFirebase(game)
            } catch {
                await setError(error)
            }
        }
    }

    // Save game document to Firebase
    func createDocumentAtFirebase(_ game: Game) async throws {
        let doc = Firestore.firestore().collection("Games").document()

        var gameWithID = game
        gameWithID.id = doc.documentID

        try await doc.setData(
            from: gameWithID,
            completion: { error in
                if error == nil {
                    isLoading = false
                    onGame(gameWithID)
                    dismiss()
                }
            })
    }

    // Handle and display errors
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

// Preview provider for Xcode
struct CreateNewGame_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewGame { _ in }
    }
}
