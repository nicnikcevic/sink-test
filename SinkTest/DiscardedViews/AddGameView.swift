//
//  AddGameView.swift
//  SinkApp
//
//  Created by Frankie Severino on 1/11/25.
//

import SwiftUI

struct AddGameView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ShrubOrTreeView()) {
                    Image("redcup2")
                        .resizable()
                        .frame(width:200, height: 250 )
                        .overlay(Text("Sink!"))
                        .font(.system(size:50))
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                }
            }
            .padding()
        }
    }
}

struct AddGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddGameView()
    }
}
