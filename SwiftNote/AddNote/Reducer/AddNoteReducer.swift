//
//  AddNoteReducer.swift
//  SwiftNote
//
//  Created by Arpana Rani on 18/03/26.
//

import Combine
import Foundation



// Reducer responsible for handling Add Note screen intents
// and updating the state accordingly (MVI pattern).

@MainActor
class AddNoteReducer: ObservableObject {
    
    // Holds the current UI state. View observes this for updates.
    @Published private(set) var state = AddNoteState()
    
    // Abstraction for data operations (e.g., saving notes via SwiftData)
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    // Processes intents and updates state
    func sendIntent(_ intent: AddNoteIntent) {
        
        switch intent {
            
        case .titleChanged(let title):
            // Update state when user edits title

            state.title = title
            
        case .descriptionChanged(let description):
            // Update state when user edits description

            state.description = description
            
        case .saveNote:
            // Trigger async save operation
            Task {
                await saveNote()
            }
            
        case .favoriteToggled(let isFavorite):
            // Update favorite status
            state.isFavorite = isFavorite
            
        default :
        break
        }
        
    }
    // Handles note creation and persistence

    private func saveNote() async {
        
        // Show loading state in UI
        state.isSaving = true
        
        // Create Note model from current state
        let note = NoteModel(
            id: Int(Date().timeIntervalSince1970),
            title: state.title,
            description: state.description,
            createdDate: Date(),
            updatedDate: Date(),
            isFavorite: state.isFavorite,
            
        )
        // Persist note using repository (SwiftData layer)
       await repository.saveNote(note)
        
        // Update state after saving
        state.isSaving = false
        state.isNoteSaved = true
    }
}

