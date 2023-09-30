//
//  URL+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

extension URL {
    static var basePath: URL {
        guard let basePath = Bundle.main.infoDictionary?["API base path"] as? String else {
            fatalError("API Base path doesn't exist in Info.plist")
        }

        guard let baseURL = URL(string: basePath) else {
            fatalError("API Base path in Info.plist is not valid")
        }

        return baseURL
    }

    static var oAuthBasePath: URL {
        guard let oAuthBasePath = Bundle.main.infoDictionary?["OAuth API base path"] as? String else {
            fatalError("OAuth API base path doesn't exist in Info.plist")
        }

        guard let oAuthBaseURL = URL(string: oAuthBasePath) else {
            fatalError("OAuth API base path in Info.plist is not valid")
        }

        return oAuthBaseURL
    }

    static func openLinkInWebBrowser(htmlURL: String) {
        guard let url = URL(string: htmlURL) else { return }
        UIApplication.shared.open(url)
    }
}
