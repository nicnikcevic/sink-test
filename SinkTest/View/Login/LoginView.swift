//
//  LoginView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//
// This file is changed very little from Template Code (See Master README.md)

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

struct LoginView: View {
    // User input and authentication state variables
    @State var emailID: String = ""
    @State var password: String = ""

    // View state management variables
    @State var createAccount: Bool = false  // Controls registration view
    @State var showError: Bool = false  // Controls error alert visibility
    @State var errorMessage: String = ""  // Stores error description
    @State var isLoading: Bool = false  // Controls loading overlay

    // Persistent app-wide storage for user information
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    @AppStorage("log_status") var logStatus: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            // Title and welcome text
            Text("Lets Sign you in")
                .font(.largeTitle.bold())
                .hAlign(.leading)

            Text("Welcome Back to Sink! You have been missed")
                .font(.title3)
                .hAlign(.leading)

            // Login input fields and actions
            VStack(spacing: 12) {
                // Email input field
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)

                // Password input field
                SecureField("Password", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))

                // Password reset button
                Button("Reset password?", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)

                // Login button
                Button(action: loginUser) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .padding(.top, 10)
            }

            // Registration prompt
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)

                Button("Register Now") {
                    createAccount.toggle()
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
        // Full-screen registration view
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
        // Error alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }

    // Authenticate user with Firebase
    func loginUser() {
        isLoading = true
        closeKeyboard()
        Task {
            do {
                // Attempt to sign in with email and password
                try await Auth.auth().signIn(
                    withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            } catch {
                await setError(error)
            }
        }
    }

    // Retrieve user data from Firestore after successful authentication
    func fetchUser() async throws {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let user = try await Firestore.firestore().collection("Users").document(
            userID
        ).getDocument(as: User.self)

        // Update app state on main thread
        await MainActor.run(body: {
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }

    // Send password reset email
    func resetPassword() {
        Task {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Sent")
            } catch {
                await setError(error)
            }
        }
    }

    // Handle and display authentication errors
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
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
