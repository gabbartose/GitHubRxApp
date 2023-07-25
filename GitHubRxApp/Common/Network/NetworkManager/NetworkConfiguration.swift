//
//  NetworkConfiguration.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

class NetworkConfiguration {
    private(set) var baseURL: URL
    private(set) var session: URLSession

    private var HTTPHeaders: [String: String]

    init(baseURL: URL = .base, HTTPHeaders: [String: String] = [:], session: URLSession = .shared) {
        self.baseURL = baseURL
        self.HTTPHeaders = HTTPHeaders
        self.session = session
    }
}
