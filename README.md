//
//  Read.swift
//  SwiftNote
//
//  Created by Arpana Rani on 25/03/26.
//

#  Notes App (MVI Architecture)

This project demonstrates a Notes app built using MVI architecture in SwiftUI.
- Integrated SwiftData with MVI to maintain a single source of truth

##  Architecture
- Intent → User actions
- State → UI state
- Reducer → Handles logic

## Screenshot
<img width="300" height="700" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-29 at 16 02 20" src="https://github.com/user-attachments/assets/e80814f1-e4cd-4732-82b4-a04df32de370" />
<img width="300" height="700" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-29 at 16 54 42" src="https://github.com/user-attachments/assets/ef49be7c-2745-4655-9b0b-b1bbd97ea051" />

## Demo
<img width="400" height="820" alt="Screen Recording 2026-04-29 at 5 16 11 PM" src="https://github.com/user-attachments/assets/e64cd229-6bf5-41e8-bc4c-8b2f52564ef5" />

##  Flow
User Action → Intent → Reducer → State → UI

##  Data Persistence (SwiftData)

This app uses **SwiftData** for local data storage.

- Notes are stored locally using SwiftData models  
- Data is fetched through the repository layer  
- The UI reflects changes automatically through state updates  


## Keychain Integration (NEW)
This project also integrates Apple Keychain Services for secure credential management.

 # Features
   * Securely stores user email and password
   * Retrieves saved credentials on app launch
   * Enables auto-login functionality
   * Provides seamless login experience without re-entering credentials


Uses iOS Keychain for encrypted local storage
Keychain Flow
User Login → Save Credentials in Keychain → App Relaunch → Fetch from Keychain → Auto-login / Auto-fill

## Architecture Update
In addition to MVI + SwiftData:
   ## KeychainManager
    * Handles secure storage and retrieval of credentials
    * Abstracts Apple Keychain APIs

   ## LoginStore
    * Manages login state
    * Integrates with Keychain for persistence logic

## Key Learnings
 * Implementing MVI in SwiftUI
 * Managing local persistence with SwiftData
 * Secure credential storage using Keychain
 * Combining authentication flow with local persistence
 * State-driven UI architecture


##  Example Flow
1. User enters email & password
2. Credentials are saved in Keychain
3. On next launch: - App checks Keychain
4. If data exists → auto-login or auto-fill occursUser taps "Add Note"
5. Intent is triggered
6. Reducer processes the intent
7. SwiftData saves the note
8. State updates
9. UI automatically refreshes  
