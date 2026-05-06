//
//  LoginReducer.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//


import Foundation

enum LoginRoute {
    case none
    case notes
}

func loginReducer(state: inout LoginState, intent: LoginIntent) {
    switch intent {
        
    case .emailChanged(let email):
        state.email = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
    case .passwordChanged(let password):
        state.password = password
        
    case .loginTapped:
        
        guard !state.email.trimmingCharacters(in: .whitespaces).isEmpty,
              !state.password.trimmingCharacters(in: .whitespaces).isEmpty else {
            state.errorMessage = "Email and Password cannot be empty"
            return
        }
        state.isLoading = true
        state.errorMessage = nil
        
    case .biometricTapped:
        state.isLoading = true
        state.errorMessage = nil
        
    case .loginSuccess:
        state.isLoading = false
        state.isLoggedIn = true
        state.route = .notes
        
    case .loginFailure(let error):
        state.isLoading = false
        state.errorMessage = error
    }
}
