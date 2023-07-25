//
//  Formatters.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

struct Formatters {
    static let shared = Formatters()

    let customIsoDateFormatter = DateFormatter()
    let standardDateFormatter = DateFormatter()
    let coordinateNumberFormatter = NumberFormatter()

    private init() {
        customIsoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        standardDateFormatter.dateFormat = "dd.MM.yyyy."
        coordinateNumberFormatter.decimalSeparator = "."
    }
}
