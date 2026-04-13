//
//  NotesRequestModels.swift
//  SwiftNote
//
//  Created by Arpana Rani on 27/03/26.
//

// NotesRequestModels.swift

import Foundation

// Encodable is a protocol
// Swift cannot encode a protocol type directly
// consider AnyEncodable as type eraser
// it encode actual object instead of "Encodable prototype"

struct AnyEncodable: Encodable {
    private let encodingHandler: (Encoder) throws -> Void

    init<T: Encodable>(_ value: T) {
        encodingHandler = value.encode
    }

    func encode(to encoder: Encoder) throws {
        try encodingHandler(encoder)
    }
}

struct CreateNoteRequest: Encodable  {
    let title: String
    let description: String
    let isFavorite: Bool
}

struct UpdateNoteRequest: Encodable  {
    let id: UUID
    let title: String
    let description: String
    let isFavorite: Bool
}
