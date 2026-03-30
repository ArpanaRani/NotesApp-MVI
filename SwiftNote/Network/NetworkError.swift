//
//  NetworkError.swift
//  SwiftNote
//
//  Created by Arpana Rani on 27/03/26.
//

enum NetworkError: Error , Equatable{
    case invalidURL
    case decodingError
    case noDataAvailable
    case serverError(Int)
    case unknown
}
