//
//  Game.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//
// This file is changed very little from Template Code (See Master README.md)

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import SwiftUI

struct RegisterView: View {
    // User registration details
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var userProfilePicData: Data?

    // View management properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false

    // Persistent app-wide storage for user information
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""

    var body: some View {
        VStack(spacing: 10) {
            // Title and welcome text
            Text("Lets Register\nAccount")
                .font(.largeTitle.bold())
                .hAlign(.leading)

            Text("Hello, good luck!")
                .font(.title3)
                .hAlign(.leading)

            // Adaptive view for different screen sizes
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false) {
                    HelperView()
                }

                HelperView()
            }

            // Login redirect
            HStack {
                Text("Already Have an account?")
                    .foregroundColor(.gray)

                Button("Login Now") {
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        // Loading overlay
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        // Photo picker integration
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            // Extract and store selected image
            if let newValue {
                Task {
                    do {
                        guard
                            let imageData = try await newValue.loadTransferable(
                                type: Data.self)
                        else { return }
                        // Ensure UI update on main thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    } catch {}
                }
            }
        }
        // Error alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }

    // Registration form view
    @ViewBuilder
    func HelperView() -> some View {
        VStack(spacing: 12) {
            // Profile picture selection
            ZStack {
                if let userProfilePicData,
                    let image = UIImage(data: userProfilePicData)
                {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, 25)

            // Input fields for registration
            TextField("Username", text: $userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            SecureField("Password", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            TextField("About you", text: $userBio, axis: .vertical)
                .frame(minHeight: 100, alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            // Sign up button
            Button(action: registerUser) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(
                userName == "" || userBio == "" || emailID == ""
                    || password == "" || userProfilePicData == nil
            )
            .padding(.top, 10)
        }
    }

    // User registration process
    func registerUser() {
        isLoading = true
        closeKeyboard()
        Task {
            do {
                // 1. Create Firebase Authentication account
                try await Auth.auth().createUser(
                    withEmail: emailID, password: password)

                // 2. Upload profile picture to Firebase Storage
                guard let userUID = Auth.auth().currentUser?.uid else { return }
                guard let imageData = userProfilePicData else { return }
                let storageRef = Storage.storage().reference().child(
                    "Profile_Images"
                ).child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)

                // 3. Get profile picture download URL
                let downloadURL = try await storageRef.downloadURL()

                // 4. Create Firestore user object
                let user = User(
                    username: userName, userBio: userBio,
                    userBioLink: userBioLink, userUID: userUID,
                    userEmail: emailID, userProfileURL: downloadURL)

                // 5. Save user document in Firestore
                let _ = try Firestore.firestore().collection("Users").document(
                    userUID
                ).setData(
                    from: user,
                    completion: { error in
                        if error == nil {
                            print("Saved Successfully")
                            userNameStored = userName
                            self.userUID = userUID
                            profileURL = downloadURL
                            logStatus = true
                        }
                    })
            } catch {
                // Delete created account in case of failure
                try await Auth.auth().currentUser?.delete()
                await setError(error)
            }
        }
    }

    // Error handling method
    func setError(_ error: Error) async {
        // Ensure UI updates occur on main thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

// Preview provider for Xcode
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
