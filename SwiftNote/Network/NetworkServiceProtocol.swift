//
//  NetworkServiceProtocol.swift
//  SwiftNote
//
//  Created by Arpana Rani on 27/03/26.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func networkRequest <T: Decodable>( _ endPoint: ApiEndpoint ) async throws -> T
}
