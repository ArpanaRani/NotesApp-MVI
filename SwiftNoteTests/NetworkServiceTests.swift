//
//  NetworkServiceTests.swift
//  SwiftNoteTests
//
//  Created by Arpana Rani on 30/03/26.
//

import XCTest
@testable import SwiftNote

@MainActor
final class NetworkServiceTests: XCTestCase {

    var mockServiceTest: MockNetworkService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override  func setUp() {
         super.setUp()
        mockServiceTest = MockNetworkService()
    }
    
    func testNetworkRequest_success_withNoteModel() async throws {
        
        //Given notesModel
        
        let mockNotesModel =  """
            {
                "notes": [
                    {
                        "id": 1,
                        "title": "Test Note 1",
                        "body": "This is description of note 1"
                    }
                ]
            }
            """.data(using: .utf8)!
        
        //when
        mockServiceTest.mockResponse = .success(mockNotesModel)
        
        let endpoint = ApiEndpoint.getNotes
        
        let result: NotesResponse = try await mockServiceTest.networkRequest(endpoint)
        
        //Then
        
        XCTAssertEqual(result.notes.first?.title, "Test Note 1")
        XCTAssertEqual(result.notes.first?.description, "This is description of note 1" )
        XCTAssertEqual(result.notes.first?.isFavorite, false) // default value
        
    }
    
    func testNetworkRequest_failure_withError() async throws {
               
        //when
        mockServiceTest.mockResponse = .failure(NetworkError.serverError(500))
        
        let endpoint = ApiEndpoint.getNotes
        // When + Then
           do {
               let _: NotesResponse = try await mockServiceTest.networkRequest(endpoint)
               XCTFail("Expected error but got success")
           } catch {
               XCTAssertEqual(error as? NetworkError, .serverError(500))
           }
        
    }
    
    func testNetworkRequest_failure_withDecodeError() async throws {
               
        //when
        mockServiceTest.mockResponse = .failure(NetworkError.serverError(500))
        
        let endpoint = ApiEndpoint.getNotes
        // When + Then
           do {
               let _: NotesResponse = try await mockServiceTest.networkRequest(endpoint)
               XCTFail("Expected error but got success")
           } catch {
               XCTAssertEqual(error as? NetworkError, .serverError(500))
           }
        
    }
    func testNetworkRequestDecodeFail() async throws {
        //Given notesModel
        
        let mockNotesModel =  """
            {
                "notes": [
                    {
                        "id": 1,
                        "title": "Test Note 1"
                    }
                ]
            }
            """.data(using: .utf8)!
        
        //when
        mockServiceTest.mockResponse = .success(mockNotesModel)
        
        let endpoint = ApiEndpoint.getNotes
        
        do {
            let _: NotesResponse = try await mockServiceTest.networkRequest(endpoint)
            XCTFail("Expected decoding to fail")
        }catch (let error){
            XCTAssertEqual(error as? NetworkError,  .decodingError )
            
        }
    }
    
    override func tearDown()  {
        mockServiceTest = nil
        super.tearDown()
        
    }

}
