//
//  MockNetworkService.swift
//  SwiftNote
//
//  Created by Arpana Rani on 30/03/26.
//
import Foundation

class MockNetworkService : NetworkServiceProtocol {
    
    enum MockResponse {
        
        case success(Data)
        case failure(Error)
    }
    var mockResponse: MockResponse?

    func networkRequest<T>(_ endPoint: ApiEndpoint) async throws -> T where T : Decodable {

        guard let mockResponse else {
            throw NetworkError.noDataAvailable
        }

        switch mockResponse {
        case .success(let data):
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }

        case .failure(let error):
            throw error
        }
    }

    
        
}
