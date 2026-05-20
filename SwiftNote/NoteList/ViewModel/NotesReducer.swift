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
class NotesReducer: ObservableObject, ReducerProtocol {

    @Published private(set) var state = NotesState()

    var repository: RepositoryProtocol
    var networkService: NetworkServiceProtocol

    init(repository: RepositoryProtocol, networkService: NetworkServiceProtocol) {
        self.repository = repository
        self.networkService = networkService
    }

    func updateRepository(_ repository: RepositoryProtocol) {
        self.repository = repository
    }

    func reduce(action: NotesIntent) {
        reduce(state: &state, action: action)
    }

    func reduce(state: inout NotesState, action: NotesIntent) {

        switch action {

        case .listNotes:
            loadNotes()

        case .setNotes(let notes):
            state.notesList = notes
            applySearch()

        case .searchNotes(let searchText):
            state.searchText = searchText
            applySearch()

        case .deleteNote(let id):
            deleteNotes(id)

        case .refreshFromDB:
            refreshFromDB()
        }
    }

    func refreshFromDB() {
        Task {
            let notes = try await repository.fetchNotes()

            await MainActor.run {
                self.state.notesList = notes
                self.state.filteredNotes = notes
            }
        }
    }
    private func applySearch() {
        if state.searchText.isEmpty {
            state.filteredNotes = state.notesList
        } else {
            state.filteredNotes = state.notesList.filter {
                $0.title.localizedCaseInsensitiveContains(state.searchText)
            }
        }
    }
    func loadNotes() {

        Task {
            await MainActor.run {
                state.isLoading = true   //  show loader
            }

            do {
                let dataRetrieved: NotesResponse =
                    try await networkService.networkRequest(ApiEndpoint.getNotes)

                let apiNotes = dataRetrieved.posts

                await repository.saveNotes(apiNotes)

                let localNotes = try await repository.fetchNotes()

                await MainActor.run {
                    state.notesList = localNotes
                    state.filteredNotes = localNotes
                    state.isLoading = false   //  hide loader
                }

            } catch {
                await MainActor.run {
                    state.isLoading = false
                }
                print("Error:", error)
            }
        }
    }
    func deleteNotes(_ noteId: Int) {
        repository.deleteNote(noteId)
    }
}
