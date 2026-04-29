//
//  LoginState.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//


struct LoginState {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    var isLoggedIn: Bool = false
    var route: LoginRoute = .none
}
