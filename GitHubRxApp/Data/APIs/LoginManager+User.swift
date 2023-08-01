//
//  LoginManager+User.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 01.08.2023..
//

import Foundation

extension LoginManager {
    
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
