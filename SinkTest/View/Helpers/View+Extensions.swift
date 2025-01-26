//
//  View+Extensions.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025

import SwiftUI

// This is a Swift extension for the View protocol, adding several utility methods to enhance UI building and manipulation

extension View {
    // Closes any active keyboard by resigning the first responder status
    // This is useful for dismissing the keyboard when needed, such as after text input or when tapping a button
    func closeKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), to: nil, from: nil,
            for: nil)
    }

    // Provides a way to disable a view and reduce its opacity when a certain condition is met
    // Useful for creating visual feedback when a view is temporarily non-interactive
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)  // Prevents user interaction
            .opacity(condition ? 0.6 : 1)  // Reduces opacity to 60% when condition is true
    }

    // Horizontally aligns the view within its available space
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }

    // Vertically aligns the view within its available space
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }

    // Adds a custom border to the view with specified width and color
    // Includes horizontal and vertical padding for better visual spacing
    // - Parameters:
    //   - width: The width of the border
    //   - color: The color of the border
    func border(_ width: CGFloat, _ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                // Creates a rounded rectangle stroke with continuous corners
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }

    // Fills the view with a specified color and adds padding
    // Creates a rounded rectangle background with the given color
    // - Parameter color: The fill color for the view's background
    func fillView(_ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                // Creates a rounded rectangle fill with continuous corners
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
}
