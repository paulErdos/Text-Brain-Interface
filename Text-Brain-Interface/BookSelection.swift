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
    
    var body: some View {
        Picker("Select a book", selection: $book) {
            ForEach(TheBooks.keys.sorted(), id: \.self) { bookName in
                Text(bookName)
            }
        }.pickerStyle(.wheel)
    }
}

//struct
