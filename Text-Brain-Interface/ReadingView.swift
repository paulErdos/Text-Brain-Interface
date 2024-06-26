//
//  ContentView.swift
//  Text-Brain-Interface
//
//  Created by Vincent Steffens on 9/6/23.
//

import SwiftUI


struct ReadingView: View {
    @State var speed = 0.0
    @State var isEditing = false
    @State private var isPaused = true
    @State private var buttonMessage = "Go!"
    @Binding var words: [String]
    @State var displayIndex: Int
    @State var title: String
    //@Binding var entered_entry: String
    
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            
            Text("\(words[displayIndex])")
                .font(.system(size: 48))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer().frame(height: 400)
            
            HStack {
                Button(action: {
                    self.backTapped()
                }) {
                    Image(systemName: "arrowshape.left.fill")
                }
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.blue)
                .cornerRadius(40)
                .foregroundColor(.white)
                
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
                
                Button(action: {
                    self.forewardTapped()
                }) {
                    Image(systemName: "arrowshape.right.fill")
                }
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.blue)
                .cornerRadius(40)
                .foregroundColor(.white)
            }

            
            Spacer().frame(height: 50)
            
            Slider(
                value: Binding(
                    get: {
                        return self.speed
                    },
                    set: { newValue in
                        if (((-20)...(-1)).contains(newValue) || (1...20).contains(newValue) || newValue == 0) {
                            self.speed = newValue
                        }
                    }
                ),
                in: -20...20,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )

            
            Spacer().frame(height: 100)
        }.onAppear {
            // Run a background task with a delay when the view appears
            var sleepTime = 1000000
            DispatchQueue.global().async {
                while true {
                    // Wait until unpause
                    while isPaused {
                        usleep(useconds_t(500000))  // 0.5 seconds
                    }
                    
                    // Once unpaused, advance word
                    if speed > 0.0 && self.displayIndex < words.count - 1 {
                        self.displayIndex += 1
                    } else if speed < 0  && self.displayIndex > 0 {
                        self.displayIndex -= 1
                    }
                    
                    // Before cycling again, wait a period of time set by the slider
                    sleepTime = speed == 0 ? 0 : abs(Int(1000000 / speed))
                    usleep(useconds_t(sleepTime))
                }
            }
        }.onDisappear {
            SavedSpots[title] = displayIndex
        }
    }
    
    private func pauseTapped() {
        isPaused.toggle()
    }
    
    private func backTapped() {
        self.displayIndex-=15
    }
    
    private func forewardTapped() {
        self.displayIndex+=15
    }
}


/*
struct ReadingView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingView(words: hhgg)
    }
}
*/
