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

##  Flow
User Action → Intent → Reducer → State → UI

##  Data Persistence (SwiftData)

This app uses **SwiftData** for local data storage.

- Notes are stored locally using SwiftData models  
- Data is fetched through the repository layer  
- The UI reflects changes automatically through state updates  

##  Features
- Fetch notes  
- Add notes  
- Local persistence using SwiftData  
- SwiftUI + MVI  

##  Example Flow
1. User taps "Add Note"  
2. Intent is triggered  
3. Reducer processes the intent  
4. SwiftData saves the note  
5. State updates  
6. UI automatically refreshes  
