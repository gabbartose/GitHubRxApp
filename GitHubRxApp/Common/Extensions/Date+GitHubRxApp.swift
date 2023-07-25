//
//  Date+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 19.07.2023..
//

import Foundation

extension Date {
    
    static func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = tempLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd.MM.yyyy.  HH:mm"
        let dateTimeString = dateFormatter.string(from: date ?? Date())
        return dateTimeString
    }
}
