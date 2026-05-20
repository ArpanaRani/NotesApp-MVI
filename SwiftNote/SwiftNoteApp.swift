//
//  SwiftNoteApp.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import SwiftUI
import SwiftData

// Entry point of the application.
// Sets up the root view and configures dependencies.
// Injects a repository into the NotesListView and initializes
// the SwiftData model container for persistence.

@main
struct SwiftNoteApp: App {

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
