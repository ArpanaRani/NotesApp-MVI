//
//  LoginReducer.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//


import Foundation

    
func loginReducer(state: inout LoginState, intent: LoginIntent) {
    switch intent {
        
    case .emailChanged(let email):
        state.email = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
    case .passwordChanged(let password):
        state.password = password
        
    case .loginTapped:
        state.isLoading = true
        state.errorMessage = nil
        
    case .loginSuccess:
        state.isLoading = false
        state.isLoggedIn = true
        
    case .loginFailure(let error):
        state.isLoading = false
        state.errorMessage = error
    }
}