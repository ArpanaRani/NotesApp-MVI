//
//  NotesReducer.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import Foundation
import Combine

// Main reducer for the Notes screen in MVI architecture.
// Acts as the central point for handling user actions (Intents),
// updating the state, and coordinating data operations via the repository.
// Ensures unidirectional data flow: Intent → Reducer → State → View.

    
@MainActor
class NotesReducer :ObservableObject, ReducerProtocol {
    
    // Holds the current UI state. Any changes trigger UI updates via @Published.
   // set -> The variable can be read from anywhere, but it can only be modified inside the class.
    @Published private(set) var state =  NotesState ()
    
    var repository: RepositoryProtocol
    
    var networkService : NetworkServiceProtocol
    // Repository is injected for flexibility (mock or real implementation)
    // Can be updated later when environment-dependent dependencies (e.g., ModelContext) are available
    init(repository: RepositoryProtocol , networkService: NetworkServiceProtocol) {
        self.repository = repository
        self.networkService = networkService
    }
    
    // Repository is initially injected, but can be updated later.
    // This allows switching to a SwiftData-backed repository once
    // ModelContext becomes available from the SwiftUI environment.
    func updateRepository(_ repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func reduce( action: NotesIntent) {
        reduce(state: &state, action: action)
    }
    func reduce(state: inout NotesState, action: NotesIntent) {
        
        switch action {
            
        case .listNotes:
            // Handle listing notes (e.g., load from repository)
            loadNotes()
            break
        
        case .searchNotes(let searchText):
            
            state.filteredNotes.removeAll()

             state.searchText = searchText
            
                if state.searchText.isEmpty {
                    state.filteredNotes = state.notesList
                } else {
                    state.filteredNotes =   state.notesList.filter {
                        $0.title.localizedCaseInsensitiveContains(searchText)
                    }
                }
        case .deleteNote(let id):
            // Handle deleting a note
            deleteNotes(id)
            break
        }
    }
    
    func loadNotes() {
        
        Task {
            
            // Step 1: Fetch API notes
            let dataRetrieved : NotesResponse = try await self.networkService.networkRequest(ApiEndpoint.getNotes)
            
            let apiNotes: [NoteModel] = dataRetrieved.posts
            // step 2: Save to DB
            await self.repository.saveNotes(apiNotes)

            let newState = state
            
            // Step 3: Fetch local notes (SwiftData)
            newState.notesList = try await self.repository.fetchNotes()
            newState.filteredNotes = newState.notesList
            state = newState   //  triggers @Published properly
        }
    }

    func deleteNotes( _ noteId : Int) {
        
        self.repository.deleteNote(noteId)

    }

}

