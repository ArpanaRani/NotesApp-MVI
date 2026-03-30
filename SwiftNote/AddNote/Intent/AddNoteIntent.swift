//
//  AddNoteIntent.swift
//  SwiftNote
//
//  Created by Arpana Rani on 18/03/26.
//
import Foundation

// Represents all user actions (Intents) for the Add Note screen.
// Each case corresponds to a specific interaction from the UI,
// which will be processed by the Reducer to update the state.

enum AddNoteIntent {
    case titleChanged(String)        // Triggered when user updates the note title
    case descriptionChanged(String)   // Triggered when user updates the note description
    case favoriteToggled(Bool)       // Triggered when user marks/unmarks as favorite
    case saveNote                    // Triggered when user taps save to create a new note
    case updateNote(id: Int, note: NoteModel)  // Triggered when updating an existing note
}
