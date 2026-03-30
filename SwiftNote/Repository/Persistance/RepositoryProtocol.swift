//
//  RepositoryProtocol.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import Foundation

// Defines a contract for data operations related to Notes.
// Abstracts the underlying data source (e.g., SwiftData, API, or mock),
// allowing the app to interact with data without knowing implementation details.
// Enables dependency injection, testability, and clean separation of concerns.

protocol RepositoryProtocol {
    
    func fetchNotes() async  throws -> [NoteModel]
    func fetchNote(id: Int) -> NoteModel?
    func saveNote(_ note: NoteModel)  async
    func deleteNote(_ noteId: Int)
    func updateNote(_ noteId: Int , note: NoteModel) 

}
