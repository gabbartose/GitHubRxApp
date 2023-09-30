//
//  KeychainManager.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 29.08.2023..
//

import Foundation
import Security

final class KeychainManager {
    struct Constants {
        static var accessToken = "access_token"
        static var usernameKey = "username_key"
        static var githubString = "github"
    }

    static let standard = KeychainManager()
    private init() { }

    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString: Any] as CFDictionary

        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            print("Error: \(status)")
        }

        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ] as [CFString: Any] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            SecItemUpdate(query, attributesToUpdate)
        }
    }

    func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as [CFString: Any] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return (result as? Data)
    }

    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as [CFString: Any] as CFDictionary

        SecItemDelete(query)
    }
}
