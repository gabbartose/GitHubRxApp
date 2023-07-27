//
//  DeepLink.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

enum DeepLink: Hashable {
    case oAuth(URL)
    
    init?(url: URL) {
        let authLinkToDeepLink: (URL) -> DeepLink = { .oAuth($0) }
        
        let deepLinkMap: [String: (URL) -> DeepLink] = [
            "\(scheme)://authentication": authLinkToDeepLink
        ]
        
        let deepLink = deepLinkMap.first(where: { url.absoluteString.hasPrefix($0.key) })?.value
        
        switch deepLink {
        case .some(let urlToDeepLink):
            self = urlToDeepLink(url)
        default:
            return nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .oAuth:
            return hasher.combine(1)
        }
    }
    
    static func ==(lhs: DeepLink, rhs: DeepLink) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
