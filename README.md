//
//  Read.swift
//  SwiftNote
//
//  Created by Arpana Rani on 25/03/26.
//

#  Notes App (MVI Architecture)

This project demonstrates a Notes app built using MVI architecture in SwiftUI.
- Integrated SwiftData with MVI to maintain a single source of truth

##  Features

- Securely stores user email and password using iOS Keychain  
- Retrieves saved credentials on app launch   
- Supports biometric authentication (Face ID) for quick and secure login  
- Create, view, and manage notes  
- Swipe to delete notes from the list  
- Seamless and state-driven UI updates  

---

##  Architecture
This project follows **MVI (Model-View-Intent)** architecture:
User Action → Intent → Reducer → State → UI  

- Intent → User actions
- State → UI state
- Reducer → Handles logic

## Screenshot
<img width="300" height="700" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-29 at 16 02 20" src="https://github.com/user-attachments/assets/e80814f1-e4cd-4732-82b4-a04df32de370" />
<img width="300" height="700" alt="Simulator Screenshot - iPhone 17 Pro - 2026-04-29 at 16 54 42" src="https://github.com/user-attachments/assets/ef49be7c-2745-4655-9b0b-b1bbd97ea051" />

## Demo
<img width="400" height="820" alt="Screen Recording 2026-04-29 at 5 16 11 PM" src="https://github.com/user-attachments/assets/e64cd229-6bf5-41e8-bc4c-8b2f52564ef5" />

##  Security

- Uses iOS Keychain for encrypted local storage  
- Face ID authentication via LocalAuthentication framework  

---

##  Data Persistence (SwiftData)

- Notes are stored locally using SwiftData models  
- Repository layer handles data operations  
- UI updates automatically based on state changes  

---

##  Keychain Integration

### Keychain Flow
User Login → Save Credentials in Keychain → App Relaunch → Fetch → Auto-login / Auto-fill → Optional Face ID Authentication  

### Components

**KeychainManager**
- Handles secure storage and retrieval of credentials  
- Abstracts Apple Keychain APIs  

**LoginStore**
- Manages login state  
- Integrates Keychain for persistence logic  

---

##  Example App Flow

1. User enters email & password  
2. Credentials are saved in Keychain  
3. On next launch, app checks Keychain  
4. If data exists → auto-login / auto-fill  
5. User taps "Add Note"  
6. Intent is triggered  
7. Reducer processes the intent  
8. SwiftData saves the note  
9. State updates  
10. UI refreshes automatically  

---

##  Key Learnings

- Implementing MVI in SwiftUI  
- Managing local persistence with SwiftData  
- Secure credential storage using Keychain  
- Biometric authentication (Face ID) integration  
- State-driven UI architecture  
