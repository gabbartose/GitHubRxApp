//
//  NetworkConfiguration.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

class NetworkConfiguration {
    
    private(set) var basePath: URL
    private(set) var oAuthBasePath: URL
    private(set) var session: URLSession
    private var HTTPHeaders: [String: String]
    
    init(basePath: URL = .basePath,
         oAuthBasePath: URL = .oAuthBasePath,
         HTTPHeaders: [String: String] = [:],
         session: URLSession = .shared) {
        self.basePath = basePath
        self.oAuthBasePath = oAuthBasePath
        self.HTTPHeaders = HTTPHeaders
        self.session = session
    }
}
