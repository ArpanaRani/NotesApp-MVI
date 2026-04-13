//
//  MockNotesRepository.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//


import Foundation

// Mock implementation of RepositoryProtocol used for testing and development.
// Provides static sample data and no-op implementations for write operations,
// allowing the app to function without a real persistence layer (e.g., SwiftData or API).
// Useful for SwiftUI previews and isolating UI/business logic from data sources.
    
class MockNotesRepository: RepositoryProtocol {
    func saveNotes(_ note: [NoteModel]) async {
        
    }
    
    
    func updateNote(_ noteId: Int, note: NoteModel) {
    }
    

    func fetchNotes() async throws -> [NoteModel] {
        // Returns static sample notes for testing/preview

        [
            NoteModel(id: Int.random(in: 100..<1000), title: "Note 1", description: "Sample 1", createdDate: Date(), updatedDate: Date(), isFavorite: false),
            NoteModel(id: Int.random(in: 100..<1000), title: "Note 2", description: "Sample 2", createdDate: Date(), updatedDate: Date(), isFavorite: true)
        ]
    }

    func fetchNote(id: Int) -> NoteModel? { nil }
    func saveNote(_ note: NoteModel) { }
    func deleteNote(_ noteId: Int) { }
    func updateNote(_ note: NoteModel) { }
}
