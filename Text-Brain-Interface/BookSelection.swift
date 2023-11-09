//
//  BookSelection.swift
//  Text-Brain-Interface
//
//  Created by Vincent Steffens on 10/14/23.
//

import SwiftUI
import Foundation

struct BookSelectionView: View {
    // The selected book
    @Binding var book: [String]
    @State var selectedBookName: String = ""
    
    var body: some View {
        List {
            Picker("Select a book", selection: $selectedBookName) {
                ForEach(TheBooks.keys.sorted(), id: \.self) { bookName in
                    Text(bookName)//.tag(TheBooks[bookName])
                }
            }.pickerStyle(.inline)
            Text("Selected book: \(selectedBookName)")
        }
    }
}

//struct
