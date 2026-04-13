//
//  NotesIntent.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import Foundation


// Represents all user actions (Intents) for the  Note list screen.
// Each case corresponds to a specific interaction from the UI,
// which will be processed by the Reducer to update the state.

// Each case automatically gets a string value:
enum NotesIntent {
    case listNotes
    case searchNotes(String)
    case deleteNote(Int)
}
