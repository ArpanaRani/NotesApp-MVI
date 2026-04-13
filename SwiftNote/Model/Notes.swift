//
//  Notes.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import Foundation

// Represents a Note entity used across the app.
// Acts as the data model for both UI state and persistence layer (SwiftData).
    
struct NoteModel: Identifiable, Decodable {
    
    let id: Int
    var title: String
    var description: String
    // Local-only properties not available in api
    var createdDate: Date = Date()
    var updatedDate: Date = Date()
    var isFavorite: Bool = false


    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "body"
    }
}


//Since api has data wrapped in "posts" as dictionary
struct NotesResponse: Decodable {
    let posts: [NoteModel]
}
