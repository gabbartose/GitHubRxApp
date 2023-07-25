//
//  ErrorReport.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

public struct ErrorReport: Error, Equatable {
    var cause: Cause
    var data: Data?

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.cause == rhs.cause && lhs.data == rhs.data
    }
}

extension ErrorReport {
    func alertable() -> AlertModel {
        switch cause {
        case .appOutdated:
            guard
                let data = data,
                let preconditionFailed: PreconditionFailedError = data.decoded() else {
                    return .unknownError
            }
            return AlertModel(title: "", message: preconditionFailed.errors.description)
        case .invalidCredentials:
            return getAlertModelForInvalidCredentials()
        case .unconfirmedAccount:
            return AlertModel(title: "Error", message: "The user account is not activated.")
        default:
            return .unknownError
        }
    }

    private func getAlertModelForInvalidCredentials() -> AlertModel {
        guard
            let data = data,
            let unprocessableEntity: UnprocessableEntity = data.decoded() else {
                return .unknownError
        }

        var message = "Something went wrong. Please contact customer support."
        if let credentialsMessage = unprocessableEntity.errors?.credentials?.first {
            message = credentialsMessage
        } else if let baseErrorsMessage = unprocessableEntity.errors?.base?.first {
            message = baseErrorsMessage
        } else if let genericMessage = unprocessableEntity.error {
            message = genericMessage
        } else if let errorsContainer = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: Any]],
                  let errors = errorsContainer["errors"], !errors.keys.isEmpty {
            message = ""

            let fieldNames = [
                "first_name": "Ime",
                "last_name": "Prezime",
                "phone_number": "Broj telefona",
                "date_of_birth": "Datum rođenja",
                "gender": "Spol",
                "email": "Email",
                "email_confirmation": "Potvrdi Email",
                "password": "Lozinka",
                "password_confirmation": "Potvrdi lozinku",
                "city": "Grad",
                "zipcode": "Poštanski broj",
                "street_name": "Ulica",
                "house_number": "Kućni broj",
                "house_letter": "Kućno slovo",
                "additional_notes": "Dodatna napomena",
                "company_name": "Ime kompanije",
                "personal_id_number": "OIB"
            ]

            errors.forEach { key, value in
                if let arrayValue = value as? [String] {
                    message.append("\(fieldNames[key] ?? key) \(arrayValue.joined(separator: ", ")).\n")
                } else {
                    message.append("\(fieldNames[key] ?? key) \(value).\n")
                }
            }
        }
        return AlertModel(title: "Error", message: message)
    }
}
