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
    
    @Query(sort: \NoteEntity.createdDate, order: .reverse)
    private var notes: [NoteEntity]
    
    @State private var isAddNote: Bool = false
    
    @StateObject var debounce = SearchDebounce(currentText: "", delay: 2.5)
    
    @StateObject private var reducer: NotesReducer
        
    init(repository: RepositoryProtocol) {
        _reducer = StateObject(
            wrappedValue: NotesReducer(
                repository: repository,
                networkService: NetworkService()
            )
        )
    }
    
    // Convert SwiftData → Model for reducer search
    var noteModels: [NoteModel] {
        notes.map { $0.toNoteModel() }
    }
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                
                if reducer.state.isLoading {
                    ProgressView("Loading Notes...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
               else if reducer.state.filteredNotes.isEmpty {
                    ContentUnavailableView("No Notes available", systemImage: "tray")
                } else {
                    List {
                        ForEach(reducer.state.filteredNotes) { note in
                            NavigationLink {
                                NoteDetailView(note: note)
                            } label: {
                                Text(note.title)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    reducer.reduce(action: .deleteNote(note.id))
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .onDelete(perform: deleteNotes)
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $debounce.currentText)
            .onChange(of: debounce.debounceValue) { _, newValue in
                reducer.reduce(action: .searchNotes(newValue))
            }
            
            //  sync DB → reducer
            .onChange(of: notes) { _, newNotes in
                let models = newNotes.map { $0.toNoteModel() }
                reducer.reduce(action: .setNotes(models))   
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddNote = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $isAddNote) {
            NavigationStack {
                AddEditNotesView(
                    reducer: AddNoteReducer(repository: reducer.repository),
                )
            }
        }
        .task {
            //  Always inject real repo
            let realRepo = SwiftNotesRepository(modelContext: modelContext)
            reducer.updateRepository(realRepo)
            
            //  API → save to SwiftData
            reducer.reduce(action: .listNotes)
        }
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            let note = reducer.state.filteredNotes[index]
            reducer.reduce(action: .deleteNote(note.id))
        }
    }
}
