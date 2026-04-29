//
//  LoginStore.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//


import Foundation
import Combine

@MainActor
final class LoginStore: ObservableObject {
    
    @Published  var state = LoginState()
  
    
    func send(_ intent: LoginIntent) {
        
        // Step 1: reduce state
        loginReducer(state: &state, intent: intent)
        
        // Step 2: handle side effects
        handleSideEffects(intent)
    }
    private func restoreSession() {
        if let token = try? KeychainManager.shared.retrieve(account: "AuthToken") {
            print("Token found:", token)
            state.isLoggedIn = true
        }
    }
    
    private func handleSideEffects(_ intent: LoginIntent) {
        switch intent {
            
        case .emailChanged:
            // Prefill the password field when the user enters a previously saved email.
            // Note: In real apps we should never store user passwords in the keychain.
            let email = state.email
            guard !email.isEmpty else {
                state.password = ""
                return
            }
            
            let account = "UserPassword:\(email)"
            if let savedPassword = try? KeychainManager.shared.retrieve(account: account) {
                state.password = savedPassword
            } else {
                state.password = ""
            }
            
        case .loginTapped:
            Task {
                // Simulate network delay
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                
                if !state.email.isEmpty && !state.password.isEmpty {
                    // Fake token
                    let token = UUID().uuidString
                    
                    // Save session token
                    // In real time app, we save acess token in Keychain
                    do {
                        try KeychainManager.shared.save(token, account: "AuthToken")
                    } catch {
                        print("Error saving access token to keychain:", error)
                    }
                    
                    // (Demo) Save "password" keyed by email so we can retrieve it later.
                    let account = "UserPassword:\(state.email)"
                    do {
                        try KeychainManager.shared.save(state.password, account: account)
                    } catch {
                        print("Error saving password to keychain:", error)
                    }
                    send(.loginSuccess)
                } else {
                    send(.loginFailure("Enter valid credentials"))
                }
            }
            
        default:
            break
        }
    }
}

