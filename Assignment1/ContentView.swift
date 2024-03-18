//
// ContentView.swift : Assignment1
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct ContentView: View {
    
    struct EmojiCounter: Identifiable {
        let id = UUID()
        var emoji: String
        var count: Int
    }
    
    @State private var emojiCounters = [
        EmojiCounter(emoji: "😂", count: 0),
        EmojiCounter(emoji: "😉", count: 0),
        EmojiCounter(emoji: "😆", count: 0),
        EmojiCounter(emoji: "😘", count: 0),
        EmojiCounter(emoji: "🤑", count: 0)
    ]
    
    @State private var lastButtonPressTime: Date? = nil
    
    let simultaneousPressThreshold: TimeInterval = 0.5
    
    var body: some View {
        NavigationView {
            List {
                ForEach($emojiCounters) { $emojiCounter in
                    HStack {
                        Text(emojiCounter.emoji)
                            .font(.largeTitle)
                        Spacer()
                        Text("Counter: \(emojiCounter.count)")
                        Spacer()
                        Button(action: {
                            print("Plus tapped for \($emojiCounter.wrappedValue.emoji)")
                            self.handleButtonPress {
                                emojiCounter.count += 1
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                        Button(action: {
                            print("Minus tapped for \($emojiCounter.wrappedValue.emoji)")
                            self.handleButtonPress {
                                emojiCounter.count -= 1
                            }
                        }) {
                            Image(systemName: "minus.square.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Emoji Counter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func handleButtonPress(action: @escaping () -> Void) {
        let now = Date()
        if let lastPressTime = lastButtonPressTime, now.timeIntervalSince(lastPressTime) <= simultaneousPressThreshold {
            print("Simultaneous press detected")
        } else {
            action()
        }
        lastButtonPressTime = now
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
