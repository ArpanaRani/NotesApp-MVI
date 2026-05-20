//
//  LoginView.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @StateObject private var store = LoginStore()

    var body: some View {

        NavigationStack {

            VStack {
                Spacer()

                VStack(spacing: 16) {

                    // Title
                    Text("Welcome Back")
                        .font(.title)
                        .fontWeight(.bold)

                    // Email Field
                    TextField(
                        "Email",
                        text: Binding(
                            get: { store.state.email },
                            set: { store.send(.emailChanged($0)) }
                        )
                    )
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .textContentType(.username)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                    // Password Field
                    SecureField(
                        "Password",
                        text: Binding(
                            get: { store.state.password },
                            set: { store.send(.passwordChanged($0)) }
                        )
                    )
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .textContentType(.password)

                    Text("Any email/password can be used. Credentials are securely stored using Keychain for learning purposes.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)

                    Text("If the same email is used again, the saved password will be auto-filled from Keychain.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)

                    // Loading
                    if store.state.isLoading {
                        ProgressView()
                            .padding(.top, 8)
                    }

                    // Login Button
                    Button("Login") {
                        store.send(.loginTapped)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(store.state.isLoading ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(store.state.isLoading)

                    if store.state.hasSavedSession, store.state.biometry != .none {
                        Button {
                            store.send(.biometricTapped)
                        } label: {
                            Text(store.state.biometry == .faceID ? "Login with Face ID" : "Login with Touch ID")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(store.state.isLoading)
                    }

                    // Error Message
                    if let error = store.state.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding(.horizontal)

                Spacer()
            }
            .background(Color(.systemGray5).ignoresSafeArea())
            .navigationDestination(isPresented: Binding(
                get: { store.state.route == .notes },
                set: { _ in store.state.route = .none }
            )) {
                NotesListView(repository: MockNotesRepository())
                    .modelContainer(for: NoteEntity.self)
            }
        }
    }
}
