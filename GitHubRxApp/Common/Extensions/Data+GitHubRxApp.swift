//
//  Data+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

// Extension for Decoding HTTP response using Codable

extension Data {
    func decoded<T: Decodable>() -> T? {
        guard !self.isEmpty else {
            return EmptyResponse() as? T
        }

        do {
            let decoder = getDecoder()
            print("decoding Decodable \(T.self)")
            return try decoder.decode(T.self, from: self)
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            }
            return nil
        }
    }

    private func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = getDateDecodingStrategy()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    private func getDateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            var date: Date?

            switch dateString.count {
            case 10, 11:
                date = Formatters.shared.standardDateFormatter.date(from: dateString)
            default:
                date = Formatters.shared.customIsoDateFormatter.date(from: dateString)
            }

            guard let theDate = date else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unable to decode date from string: \(dateString)")
            }

            return theDate
        }
    }
}

