//
//  Untitled.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import Foundation

// Mock implementation of NotesReducer used for testing and SwiftUI previews.
// Provides pre-filled sample data without relying on the actual repository or persistence layer,
// enabling faster UI development and isolation from real data sources.

    
@MainActor
class MockNotesReducer : ReducerProtocol{
    
    func reduce(state: inout NotesState, action: NotesIntent) {
        
    }
    
    typealias State = NotesState
    
    typealias Action = NotesIntent
    

    let mockRepository = MockNotesRepository()
    let state  = NotesState()
    init() {

        // Pre-fill some notes for preview WITHOUT touching repository
        self.state.notesList = [
            NoteModel(id: UUID(), title: "Note 1", description: "Sample 1", createdDate: Date(), updatedDate: Date(), isFavorite: false),
            NoteModel(id: UUID(), title: "Note 2", description: "Sample 2", createdDate: Date(), updatedDate: Date(), isFavorite: true)
        ]
    }
}
