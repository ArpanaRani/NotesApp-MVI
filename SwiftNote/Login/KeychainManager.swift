//
//  KeychainHelper.swift
//  SwiftNote
//
//  Created by Arpana Rani on 28/04/26.
//

import Foundation
import Security

enum KeychainError: Error {
    case duplicateData
    case itemnotFound
    case invalidItem
    case invalidData
    case unhandledError(OSStatus)
}
final class KeychainManager {

    static let shared = KeychainManager()
    private init() {}
    let service = Bundle.main.bundleIdentifier ?? "arpana.SwiftNote"

   // MARK: - Save

    func save(_ value: String, account: String) throws {

        guard let dataRetrieved = value.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: dataRetrieved
        ]

        // Delete if exists (avoid duplicate error)
         SecItemDelete(query as CFDictionary)

        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                throw KeychainError.duplicateData
            } else {
                throw KeychainError.unhandledError(status)
            }
        }
    }

    func retrieve(account: String) throws -> String {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status != errSecItemNotFound else {
               throw KeychainError.itemnotFound
           }

        guard   status == errSecSuccess else {
            throw KeychainError.unhandledError(status)
        }

        guard let retrievedData = result as? Data, let value = String(data: retrievedData, encoding: .utf8) else {
            throw KeychainError.invalidData
        }

        return value
    }

}
