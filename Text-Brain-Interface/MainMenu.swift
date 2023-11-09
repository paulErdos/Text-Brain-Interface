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
    @State var selectedBook: [String] = talesofspaceandtime
    @State var selectedBookName: String = "Tales of Space and Time"
    
    var body: some View {
        NavigationView {
            List {
                Picker("Select a book", selection: $selectedBookName) {
                    ForEach(TheBooks.keys.sorted(), id: \.self) { bookName in
                        Text(bookName).tag(TheBooks[bookName])
                    }
                }
                .onReceive(Just(selectedBookName)) { key in
                    selectedBook = TheBooks[key] ?? talesofspaceandtime
                }
                .pickerStyle(.inline)
                // TODO: Add "Add your own text" view. Persist added text. 
                //NavigationLink(destination: )
                NavigationLink(destination: ReadingView(words: $selectedBook,
                                                       displayIndex: SavedSpots[selectedBookName]!,
                                                        title: selectedBookName)) {
                    Label("Read", systemImage: "book")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }//.disabled(selectedBookName == "")
            }
            .navigationTitle("Text-Brain Interface")
        }
    }
}
