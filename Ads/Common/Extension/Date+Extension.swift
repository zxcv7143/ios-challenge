//
//  Date+Extension.swift
//  Ads
//
//  Created by Anton Zuev on 17/3/25.
//
import Foundation

extension Date {
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: self)
    }
    
}


