//
//  URL+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

extension URL {
    static var base: URL {
        guard let basePath = Bundle.main.infoDictionary?["API base path"] as? String else {
            fatalError("API Base path doesn't exist in Info.plist")
        }
        
        guard let baseURL = URL(string: basePath) else {
            fatalError("API Base path in Info.plist is not valid")
        }
        
        return baseURL
    }
    
    static func openLinkInWebBrowser(htmlURL: String) {
        guard let url = URL(string: htmlURL) else { return }
        UIApplication.shared.open(url)
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
