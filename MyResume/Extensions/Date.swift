//
//  Date.swift
//  MyResume
//
//  Created by Arthur Kleiber on 22/01/2021.
//

import Foundation

extension Date {
    static func getShortDateAsString(from ISO8601String: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: ISO8601String) else {
            return "Unknown"
        }
        
        dateFormatter.dateFormat = "MMM YYYY"
        return dateFormatter.string(from: date)
    }
}
