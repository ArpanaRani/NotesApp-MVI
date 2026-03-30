//
//  SearchDebounce.swift
//  SwiftNote
//
//  Created by Arpana Rani on 24/03/26.
//
import Combine
import SwiftUI


// Handles debouncing of user input using Combine.
// Converts rapid text changes into a stable output after a delay,
// helping optimize operations like search or filtering by avoiding
// excessive updates.
    
class SearchDebounce: ObservableObject {
    @Published var currentText: String = ""
    @Published var debounceValue: String = ""
    var anyCancellable =  Set<AnyCancellable>()
    
    init(currentText: String, delay: Double) {
        _currentText = Published(initialValue: currentText)
        _debounceValue = Published(initialValue: currentText)
        // Emits debounced value after delay
        $currentText.debounce(for: .seconds(delay), scheduler: RunLoop.main)
            .sink { value in
                self.debounceValue = value
                print("Debounced value:", value)
            }
            .store(in: &anyCancellable)
            //.assign(to: &$debounceValue)
        
        
    }
}
    

