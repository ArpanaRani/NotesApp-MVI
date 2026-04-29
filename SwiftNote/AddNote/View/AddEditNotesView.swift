//
//  AddEditNotesView.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//
import SwiftUI

// SwiftUI View for the Add Note screen.
// Observes state from AddNoteReducer and renders UI accordingly.
// Sends user actions as Intents to the reducer, maintaining
// unidirectional data flow (MVI architecture).
struct AddEditNotesView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var reducer: AddNoteReducer
        
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Add Note")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            
            TextField(
                "Title",
                text: Binding(
                    get: { reducer.state.title },
                    set: { reducer.sendIntent(.titleChanged($0)) }
                )
            )
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            
            TextEditor(
                text: Binding(
                    get: { reducer.state.description },
                    set: { reducer.sendIntent(.descriptionChanged($0)) }
                )
            )
            .frame(height: 200)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            
            Toggle(
                "Favorite",
                isOn: Binding(
                    get: { reducer.state.isFavorite },
                    set: { reducer.sendIntent(.favoriteToggled($0)) }
                )
            )
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                reducer.sendIntent(.saveNote)
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Add Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()   // only dismiss
                }
            }
        }
        .onChange(of: reducer.state.isNoteSaved) { _, newValue in
            if newValue {
                dismiss() // close screen
            }
        }
    }
}
