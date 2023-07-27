//
//  DeepLinkHandler.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

let scheme = "com.beer.GitHubRxApp"

class DeepLinkHandler {
    typealias DeeplinkCallback = (DeepLink) -> ()
    
    var callbackMap: [DeepLink: DeeplinkCallback] = [:]
    
    func addCallback(_ callback: @escaping DeeplinkCallback, forDeepLink deepLink: DeepLink) {
        callbackMap[deepLink] = callback
    }
    
    func handleDeepLinkIfPossible(deepLink: DeepLink) {
        guard let callback = callbackMap[deepLink] else { return  }
        
        callback(deepLink)
    }
}
