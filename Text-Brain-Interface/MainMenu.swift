//
//  MainMenu.swift
//  Text-Brain-Interface
//
//  Created by Vincent Steffens on 10/14/23.
//

import SwiftUI


struct MainMenu: View {
    // The selected book
    @State var book: [String]
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BookSelectionView(book: $book)) {
                    Label("Choose A Book", systemImage: "books.vertical")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                NavigationLink(destination: ReadingView(words: $book)) {
                    Label("Read", systemImage: "book")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }
            .navigationTitle("Text-Brain Interface")
        }
    }
}
