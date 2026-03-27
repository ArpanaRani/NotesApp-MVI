//
//  NetworkService.swift
//  SwiftNote
//
//  Created by Arpana Rani on 27/03/26.
//

import  Foundation

class NetworkService : NetworkServiceProtocol {
    
     private   let baseURL = "https://dummyjson.com" // this will move to buildSetting/Usertype later

    func networkRequest <T: Decodable>( _ endPoint: ApiEndpoint ) async throws -> T {

        
         guard let url = URL(string: "\(baseURL)\(endPoint.path)") else {
            throw URLError(.badURL)
        }
        var urlRequest =  URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        
        if let body = endPoint.body {
            urlRequest.httpBody = try JSONEncoder().encode(AnyEncodable(body))
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
