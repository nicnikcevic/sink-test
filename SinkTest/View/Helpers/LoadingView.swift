//
//  LoadingView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import SwiftUI

// Defining a struct named LoadingView
struct LoadingView: View {
    // A binding property to control the visibility of the loading view
    @Binding var show: Bool

    // The body property defines the UI for the LoadingView
    var body: some View {
        // A ZStack to layer views on top of each other
        ZStack {
            // Conditional check to display the loading view if `show` is true
            if show {
                Group {
                    // A semi-transparent black rectangle that covers the entire screen
                    Rectangle()
                        .fill(.black.opacity(0.25))  // Sets the fill color with opacity
                        .ignoresSafeArea()  // Ensures the rectangle covers the safe area

                    // A ProgressView with a background
                    ProgressView()
                        .padding(15)  // Adds padding around the ProgressView
                        .background(  // Sets a white background with rounded corners
                            .white,
                            in: RoundedRectangle(
                                cornerRadius: 10, style: .continuous)
                        )
                }
            }
        }
        // Adds an animation to changes in the `show` property
        .animation(.easeInOut(duration: 0.25), value: show)
    }
}
