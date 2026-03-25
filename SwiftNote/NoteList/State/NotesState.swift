//
//  NotesState.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import Combine

// Represents the UI state for the  Note List screen in MVI architecture.
// This acts as a single source of truth, and any changes to this state
// automatically reflect in the UI.

class NotesState {
    
     var notesList: [NoteModel] = []
     var isLoading: Bool = false
     var isSearchActive: Bool = false
     var isNoteDeleted: Bool = false
     var isNoteSaved : Bool = false
     var filteredNotes: [NoteModel] = []
     var searchText: String = ""
}


