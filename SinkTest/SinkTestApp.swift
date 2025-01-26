//
//  SinkTestApp.swift
//  SinkTest
//
//  Created by Nic Nikcevic on 1/18/25.
//

import SwiftUI
import Firebase

//This is the landing file for the SinkTestApp
@main
struct SinkTestApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
