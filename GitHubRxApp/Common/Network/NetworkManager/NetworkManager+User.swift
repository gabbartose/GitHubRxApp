//
//  NetworkManager+User.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 03.08.2023..
//

import Foundation

// MARK: UserDefaults related topics
/**
 accessTokenKey
 refreshTokenKey
 usernameKey
 */
extension NetworkManager {
    
    // MARK: User related keys defined on GitHub
    static let callbackURLScheme = "com.beer.GitHubRxApp"
    static let clientID = "Iv1.03eda0e0b6c3100b"
    static let clientSecret = "370d1b2a85339484e0bb76c26a214ffbac09a388"
    
    // MARK: Static Methods
    static func signOut() {
        Self.accessToken = ""
        Self.refreshToken = ""
        Self.username = ""
    }
    
    // MARK: Private Constants
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    private static let usernameKey = "username"
    
    // MARK: Properties
    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
        }
    }
    
    static var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey)
        }
    }
    
    static var username: String? {
        get {
            UserDefaults.standard.string(forKey: usernameKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: usernameKey)
        }
    }
    
    static func printTokens() {
        print("accessToken: \(accessToken ?? "")")
        print("refreshToken: \(refreshToken ?? "")")
        print("username: \(username ?? "")")
    }
}
