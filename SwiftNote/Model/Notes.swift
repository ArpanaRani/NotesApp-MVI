//
//  Notes.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import Foundation

// Represents a Note entity used across the app.
// Acts as the data model for both UI state and persistence layer (SwiftData).
    
struct NoteModel: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var createdDate: Date
    var updatedDate: Date
    var isFavorite: Bool
}
