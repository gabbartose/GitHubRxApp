//
//  AlertModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

struct AlertModel {
    var title: String
    var message: String
}

extension AlertModel {
    static var unknownError: AlertModel {
        return AlertModel(title: "Error",
                          message: "Something went wrong. Please contact customer support.")
    }
}
