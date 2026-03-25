//
//  NotesListView.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import SwiftUI
import SwiftData

// SwiftUI View for the  Note list screen.
// Observes state from NotesReducer and renders UI accordingly.
// Sends user actions as Intents to the reducer, maintaining
// unidirectional data flow (MVI architecture).

struct NotesListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var isAddNote: Bool = false
    @State var isSearchActive: Bool = false
    @StateObject var debounce = SearchDebounce(currentText: "", delay: 2.5)
    @StateObject private var reducer : NotesReducer
        
    init(repository: RepositoryProtocol) {
        _reducer = StateObject(
            wrappedValue: NotesReducer(repository:  MockNotesRepository()))
    }
    
    var body: some View {
        
        NavigationStack {
            
            if reducer.state.filteredNotes.isEmpty {
                ContentUnavailableView("No Notes available", systemImage: "tray")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action:  {
                                print("add btn pressed")
                                isAddNote = true
                            } ){
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .navigationDestination(isPresented: $isAddNote) {
                        AddEditNotesView(reducer: AddNoteReducer(repository: reducer.repository),
                                         onSaveNewNote:  {
                            reducer.reduce(action: .listNotes)
                        })
                    }
            } else {
                List(reducer.state.filteredNotes) { note in
                    NavigationLink(destination: NoteDetailView()) {
                        Text(note.title)
                    }
                }
                .searchable(text: $debounce.currentText)
                .onChange(of: debounce.debounceValue) { oldValue, newValue in
                    reducer.reduce(action: .searchNotes(newValue))
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action:  {
                            print("add btn pressed")
                            isAddNote = true
                        } ){
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationDestination(isPresented: $isAddNote) {
                    AddEditNotesView(reducer: AddNoteReducer(repository: reducer.repository),
                                     onSaveNewNote:  {
                        reducer.reduce(action: .listNotes)
                    })
                }
            }
        }
        .task {
            //  Inject real repository here using modelContext
            if reducer.repository is MockNotesRepository {
                let realRepo = SwiftNotesRepository(modelContext: modelContext)
                reducer.updateRepository(realRepo)
            }
            reducer.reduce(action: .listNotes)
        }
        
    }
}

#Preview {
    NotesListView(repository: MockNotesRepository())
}

