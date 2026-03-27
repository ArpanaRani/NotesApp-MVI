//
//  NetworkAPIEndpint.swift
//  SwiftNote
//
//  Created by Arpana Rani on 27/03/26.
//

import Foundation


// MARK: - API Endpoint Definition
// This enum defines all Notes-related API endpoints.
// Each case represents a specific API call and can carry associated request data.
// It abstracts path, HTTP method, and request body, keeping the network layer clean and reusable.

protocol APIEndpointProtocol {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ApiEndpoint {
    
    case getNotes
    case createNote(CreateNoteRequest)
    case updateNote (UpdateNoteRequest)
    case deleteNote(UUID)
    
}
extension ApiEndpoint : APIEndpointProtocol {
        
    var path: String {
        switch self {
            
        case .getNotes:
            return "/posts"
            
        case .createNote:
            return "/posts/add"
            
        case .updateNote(let request):
            return "/posts/\(request.id)"
            
        case .deleteNote(let id):
            return "/posts/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNotes: return HTTPMethod.GET
        case .createNote: return HTTPMethod.POST
        case .updateNote: return HTTPMethod.PUT
        case .deleteNote: return HTTPMethod.DELETE
        }
    }
    
    var body: Encodable? {
          switch self {
          case .getNotes:
              return nil
          case .createNote(let request):
              return request
          case .updateNote(let request):
              return request
          case .deleteNote:
              return nil
          }
      }
}
