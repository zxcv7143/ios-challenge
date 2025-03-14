//
//  UILabel+Extension.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//


import UIKit


extension UILabel {
    
    func setStyle(font: UIFont? = nil, textColor: UIColor? = nil, text: String? = nil) {
        if let font = font { self.font = font }
        if let textColor = textColor { self.textColor = textColor }
        if let text = text { self.text = text }
    }
    
}