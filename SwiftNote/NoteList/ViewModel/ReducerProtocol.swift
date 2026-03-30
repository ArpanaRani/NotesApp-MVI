//
//  Untitled 2.swift
//  SwiftNote
//
//  Created by Arpana Rani on 17/03/26.
//

import Foundation


// Generic protocol defining the contract for a Reducer in MVI architecture.
// A Reducer is responsible for taking the current state and an action (Intent),
// and producing a new state by applying the required changes.
// Enables reusable and testable state management across different features.


protocol ReducerProtocol{
    associatedtype State
    associatedtype Action

    func reduce(state: inout State, action: Action)
}
