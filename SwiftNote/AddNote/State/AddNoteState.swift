//
//  AddNoteState.swift
//  SwiftNote
//
//  Created by Arpana Rani on 18/03/26.
//

// Represents the UI state for the Add Note screen in MVI architecture.
// This acts as a single source of truth, and any changes to this state
// automatically reflect in the UI.

struct AddNoteState {
    var title: String = ""
    var description: String = ""
    var isSaving: Bool = false
    var isFavorite: Bool = false
    var isNoteSaved: Bool = false
}
