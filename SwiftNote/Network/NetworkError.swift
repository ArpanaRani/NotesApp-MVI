//
//  NetworkError.swift
//  SwiftNote
//
//  Created by Arpana Rani on 27/03/26.
//

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noDataAvailable
    case serverError(Int)
    case unknown
}
