//
//  Untitled.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import SwiftData
import Foundation

// SwiftData entity representing a Note in the persistence layer.
// Used for storing and retrieving note data from the local database.
// Kept separate from NoteModel to maintain a clear separation between
// persistence and application layers.

@Model
class NoteEntity: Identifiable {
    var id: Int
    var title: String
    var descriptionNotes: String
    var createdDate: Date
    var updatedDate: Date
    var isFavorite: Bool
    
    init(id: Int,
          title: String,
         descriptionNotes: String,
          createdDate: Date,
          updatedDate: Date,
          isFavorite: Bool) {

         self.id = id
         self.title = title
         self.descriptionNotes = descriptionNotes
         self.createdDate = createdDate
         self.updatedDate = updatedDate
         self.isFavorite = isFavorite
     }
}

//Extension to add a function for mapping NoteEntity to NoteModel
extension NoteEntity {
    // Converts SwiftData entity into domain model
    func toNoteModel() -> NoteModel {
        NoteModel(id: id,
                  title: title,
                  description: descriptionNotes,
                  createdDate: createdDate,
                  updatedDate: updatedDate,
                  isFavorite: isFavorite)
    }
    
}
