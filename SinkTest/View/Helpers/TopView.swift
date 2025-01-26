//
//  SearchUserView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import SwiftUI

struct TopView: View {
    var body: some View {
        HStack {
            Spacer()
            Image("sink_tile_white")  // Replace with your asset name
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                //.frame(width: 500, height: 50) // Adjust size as needed
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)  // Tint color for the image
            //.clipped()
            Spacer()
        }
        .padding(10)
        .background(Color(red: 185 / 255, green: 15 / 255, blue: 20 / 255))  // Hex #B80F14
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
