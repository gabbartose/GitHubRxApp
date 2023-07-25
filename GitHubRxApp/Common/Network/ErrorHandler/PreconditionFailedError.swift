//
//  PreconditionFailedError.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

struct Credentials: Codable {
    let error: String?
}

struct Details: Codable {
    let credentials: [Credentials]?
}

struct Errors: Codable {
    let credentials: [String]?
    let base: [String]?
}

struct UnprocessableEntity: Codable {
    let error: String?
    let errors: Errors?
    let details: Details?
}

struct PreconditionFailedError: Codable {
    var errors: PreconditionFailed
}

struct PreconditionFailed: Codable {
    var code: Int
    var description: String
}
