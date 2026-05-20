//
//  LoginIntent.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//

enum LoginIntent {
    case emailChanged(String)
    case passwordChanged(String)
    case loginTapped
    case biometricTapped
    case loginSuccess
    case loginFailure(String)
}
