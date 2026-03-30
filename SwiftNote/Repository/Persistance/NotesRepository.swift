//
//  Repository.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import Foundation
import SwiftData

// Concrete implementation of RepositoryProtocol using SwiftData for persistence.
// Handles CRUD operations for notes by interacting with ModelContext.
// Converts between NoteEntity (SwiftData layer) and NoteModel (app layer),
// ensuring separation of concerns and clean architecture.
    
class SwiftNotesRepository : RepositoryProtocol {
        
    var modelContext : ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // Fetches all notes from SwiftData and maps them to NoteModel
    func fetchNotes() async throws -> [NoteModel] {
        
     let descriptor = FetchDescriptor<NoteEntity>()
        do {
           let entity = try self.modelContext.fetch(descriptor)
            return entity.map { $0.toNoteModel() }
        } catch {
            throw error
        }
    }
    
    // Fetches a single note by ID using predicate filtering
    func fetchNote(id: UUID) -> NoteModel? {
        
        let descriptor  = FetchDescriptor<NoteEntity>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            let retrivedEntity = try self.modelContext.fetch(descriptor)
            return retrivedEntity.first?.toNoteModel()
        }
        catch {
            print("Fetch note for \(id)  failed: \(error)")

        }
        return nil
    }
    
    // Saves a new note to SwiftData
    // Converts NoteModel to NoteEntity before insertion
    func saveNote(_ note: NoteModel) {
        
        let entity = NoteEntity(id: note.id, title: note.title, descriptionNotes: note.description , createdDate: Date(), updatedDate: Date(), isFavorite: note.isFavorite )
            self.modelContext.insert(entity)
        do {
            try self.modelContext.save()
        }
        catch{
            print("Save failed: \(error)")
        }
        
    }
    
    // Deletes a note from SwiftData using its ID
    func deleteNote(_ noteId: UUID) {
        let descriptor  = FetchDescriptor<NoteEntity>(
            predicate: #Predicate { $0.id == noteId }
        )
        do {
            let retrivedEntity = try self.modelContext.fetch(descriptor)
            if let entity = retrivedEntity.first {
                     modelContext.delete(entity)
                 }

             } catch {
                 print("Delete failed: \(error)")
             }
    }
        
    // Updates an existing note in SwiftData
    // Fetches the entity, modifies fields, and saves context
    
    func updateNote(_ noteId: UUID , note: NoteModel) {
        
        let descriptor  = FetchDescriptor<NoteEntity>(
            predicate: #Predicate { $0.id == noteId }
        )
        do {
            let retrivedEntity = try self.modelContext.fetch(descriptor)
            if let entity = retrivedEntity.first {
                entity.title = note.title
                entity.descriptionNotes = note.description
                entity.updatedDate = Date()
                entity.isFavorite = note.isFavorite
                
                
                try modelContext.save()
            }
            
        } catch {
            print("Delete failed: \(error)")
        }
    }
}
