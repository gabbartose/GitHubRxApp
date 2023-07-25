//
//  Resource.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

enum RequestMethod: String {
    case get
    case post
    case put
    case delete
    case head
    case PATCH
}

enum APIVersion: String {
    case v1 = "/api/v1"
    case v2 = "/api/v2"
    case none = ""
}

struct Resource<T> {
    let path: String
    var method: RequestMethod = .get
    var headers: [String: String] = [:]
    var requestBody: [String: Any]?
    var queryItems: [URLQueryItem]?
    var api: APIVersion = .v2
}

extension Resource {
    init(path: String, method: RequestMethod = .get) {
        self.path = path
        self.method = method
    }
}

/// Used when HTTP response body is empty
typealias EmptyResponse = String


