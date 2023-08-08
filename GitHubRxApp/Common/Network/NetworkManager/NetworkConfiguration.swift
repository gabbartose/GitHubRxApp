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
    private var computedHTTPHeaders: (() -> [String: String])?
    
    var requiredHTTPHeaders: [String: String] {
        guard let computedHeaders = computedHTTPHeaders?() else {
            return HTTPHeaders
        }
        var headers = HTTPHeaders
        computedHeaders.forEach { headers[$0.key] = $0.value }
        return headers
    }
    
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
