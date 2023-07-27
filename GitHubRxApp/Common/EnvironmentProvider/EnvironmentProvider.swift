//
//  EnvironmentProvider.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 26.07.2023..
//

import Foundation

enum Environment: String, CaseIterable {
    case production = "com.beer.GitHubRxApp-production"
    case staging = "com.beer.GitHubRxApp-staging"
    case test = "com.beer.GitHubRxApp-test"
}

struct EnvironmentProvider {
    
    var currentEnvironment: Environment
    static let shared = EnvironmentProvider()
    
    private init() {
        if let environmentString = Bundle.main.infoDictionary?["App Bundle ID"] as? String,
           let environment = Environment(rawValue: environmentString) {
            self.currentEnvironment = environment
            print("Current environment is: \(currentEnvironment)")
        } else {
            fatalError("No valid environment available!")
        }
    }
    
    func isProduction() -> Bool {
        return EnvironmentProvider.shared.currentEnvironment == .production
    }
    
    func isStaging() -> Bool {
        return EnvironmentProvider.shared.currentEnvironment == .staging
    }
    
    func isTest() -> Bool {
        return EnvironmentProvider.shared.currentEnvironment == .test
    }
    
    func getCurrentEnvironment() -> String {
        return currentEnvironment.rawValue
    }
}
