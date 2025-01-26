//
//  TimerView.swift
//  SinkApp
//
//  Created by Frankie Severino on 1/11/25.
//

import SwiftUI

struct TimerView: View {
    @State private var timeRemaining: Int = 5
    @State private var timerActive: Bool = false    
    var body: some View {
        VStack(spacing: 20) {
            Text("Time Remaining")
                .font(.largeTitle)

            Text("\(timeRemaining / 60):\(String(format: "%02d", timeRemaining % 60))")
                .font(.system(size: 72, weight: .bold, design: .monospaced))

            if timeRemaining > 0 {
                Button(action: startTimer) {
                    Text("Start Timer")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(timerActive)
            } else {
                NavigationLink(destination: PostGameView()) {
                    Text("Next")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if timerActive && timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }

    func startTimer() {
        timerActive = true
    }
}
//
//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}
