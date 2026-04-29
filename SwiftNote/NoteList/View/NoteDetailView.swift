//
//  Untitled.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import SwiftUI

struct NoteDetailView: View {
    
    let note: NoteModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(note.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(note.description)
                .font(.body)
            
            if note.isFavorite {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Favorite")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
