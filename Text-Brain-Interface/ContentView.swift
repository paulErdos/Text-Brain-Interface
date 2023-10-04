//
//  ContentView.swift
//  Text-Brain-Interface
//
//  Created by Vincent Steffens on 9/6/23.
//

import SwiftUI


struct ContentView: View {
    @State var speed = 0.0
    @State var isEditing = false
    @State private var displayIndex = 0
    @State private var isPaused = false
    @State private var buttonMessage = "Go!"
    //@Binding var text: String
    //@Binding var entered_entry: String
    
    var body: some View {
        
        VStack {
            Button(action: {
                self.pauseTapped()
            }) {
                if isPaused {
                    Image(systemName: "play.circle.fill")
                } else {
                    Image(systemName: "pause.circle.fill")
                }
            }
            .font(.title)
            .frame(width: 80, height: 80)
            .background(Color.blue)
            .cornerRadius(40)
            .foregroundColor(.white)
            
            Slider(
                value: $speed,
                in: -20...20,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
            Text("\(words[displayIndex])")
        }.onAppear {
            // First, we're just iterating through with no control
            let increment = 1
            let decrement = -1
            
            // Run a background task with a delay when the view appears
            var sleepTime = 1000000
            DispatchQueue.global().async {
                while true {
                    if !isPaused {
                        sleepTime = speed == 0 ? 0 : abs(Int(1000000 / speed))
                        usleep(useconds_t(sleepTime))
                    } else {
                        while isPaused {
                            usleep(useconds_t(1000000))
                        }
                    }
                    sleepTime = speed == 0 ? 0 : abs(Int(1000000 / speed))
                    usleep(useconds_t(sleepTime))
                    if speed > 0.0 && self.displayIndex < words.count - 1 {
                        self.displayIndex += increment
                    } else if speed < 0  && self.displayIndex > 0 {
                        self.displayIndex += decrement
                    }
                    //Thread.sleep(forTimeInterval: 1.0) // Sleep for 1 second
                }
            }
        }
    }
    
    private func pauseTapped() {
        isPaused.toggle()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
