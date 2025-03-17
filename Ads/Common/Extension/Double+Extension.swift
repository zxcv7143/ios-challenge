//
//  Double+Extension.swift
//  Ads
//
//  Created by Anton Zuev on 16/3/25.
//
import Foundation

extension Double {
    
    func moneyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        } else { return "" }
    }
    
}
