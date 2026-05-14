//
//  LoginReducerTests.swift
//  SwiftNoteTests
//

import XCTest
@testable import SwiftNote

final class LoginReducerTests: XCTestCase {

    func test_loginTapped_whenEmailAndPasswordAreNonEmpty_startsLoadingAndClearsError() {
        var state = LoginState()
        state.email = "user@example.com"
        state.password = "secret"

        loginReducer(state: &state, intent: .loginTapped)

        XCTAssertTrue(state.isLoading)
        XCTAssertNil(state.errorMessage)
    }

    func test_loginTapped_whenEmailOrPasswordEmpty_setsErrorAndDoesNotStartLoading() {
        var state = LoginState()
        state.email = ""
        state.password = ""

        loginReducer(state: &state, intent: .loginTapped)

        XCTAssertEqual(state.errorMessage, "Email and Password cannot be empty")
        XCTAssertFalse(state.isLoading)
    }

    func test_loginTapped_whenOnlyPasswordProvided_setsError() {
        var state = LoginState()
        state.email = ""
        state.password = "secret"

        loginReducer(state: &state, intent: .loginTapped)

        XCTAssertEqual(state.errorMessage, "Email and Password cannot be empty")
        XCTAssertFalse(state.isLoading)
    }

    func test_loginTapped_whenOnlyEmailProvided_setsError() {
        var state = LoginState()
        state.email = "user@example.com"
        state.password = ""

        loginReducer(state: &state, intent: .loginTapped)

        XCTAssertEqual(state.errorMessage, "Email and Password cannot be empty")
        XCTAssertFalse(state.isLoading)
    }

    func test_loginTapped_whenFieldsAreWhitespaceOnly_setsError() {
        var state = LoginState()
        state.email = "   "
        state.password = "  \t"

        loginReducer(state: &state, intent: .loginTapped)

        XCTAssertEqual(state.errorMessage, "Email and Password cannot be empty")
        XCTAssertFalse(state.isLoading)
    }
}
