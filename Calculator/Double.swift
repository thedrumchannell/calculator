//
//  Double.swift
//  Calculator
//
//  Created by Developer on 12/24/18.
//  Copyright © 2018 Brandon Channell. All rights reserved.
//

import Foundation

extension Double
{
    var decimal: String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 500000
        formatter.groupingSize = 0
        return String(formatter.string(from: number) ?? "")
    }
    
    var scientific: String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "e"
        return String(formatter.string(from: number) ?? "")
    }
    
    var rounded: String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = 8
        formatter.groupingSize = 0
        return String(formatter.string(from: number) ?? "")
    }
}
