//
//  ContentView.swift
//  SinkTest
//
//  Created by Nic Nikcevic, Andrew Heller, Francesco Severino
//  January 2025
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        // MARK: Redirecting User Based on Log Status
        if logStatus{
            MainView()
        }else{
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
