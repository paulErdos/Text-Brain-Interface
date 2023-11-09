//
//  MainMenu.swift
//  Text-Brain-Interface
//
//  Created by Vincent Steffens on 10/14/23.
//

import SwiftUI
import Combine

struct MainMenu: View {
    // The selected book
    //@State var selectedBook: [String] = talesofspaceandtime
    @State var selectedTitle: String = "Tales of Space and Time"
    
    var body: some View {
        NavigationView {
            List {
                Picker("Select a book", selection: $selectedTitle) {
                    ForEach(TheBooks.keys.sorted(), id: \.self) { bookName in
                        Text(bookName)//.tag(TheBooks[bookName])
                    }
                }
                /*.onReceive(Just(selectedTitle)) { key in
                    selectedBook = TheBooks[key] ?? talesofspaceandtime
                }
                */.pickerStyle(.inline)
                
                NavigationLink(destination: ReadingView(title: $selectedTitle)) {
                    Label("Read", systemImage: "book")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }
            .navigationTitle("Text-Brain Interface")
        }
    }
}
