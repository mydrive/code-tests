//
//  Globals.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 03/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

import Foundation
import UIKit

let defaultURLString : String = "https://raw.githubusercontent.com/mydrive/code-tests/master/iOS-currency-exchange-rates/rates.json"
let currencies : Array<String> = ["EUR", "USD", "JPY", "GBP", "CHF", "CAD", "AUD"]

/**
 Some standard sizes for layouts
 */
let topMargin: CGFloat = 20.0
let standardControlHeight: CGFloat = 30.0
let standardPickerHeight: CGFloat = 50.0

/**
 Define colours globally for easy skinning
 */
let backgroundColor = UIColor(hexString: "#AA43A1")

/**
 Prints a message to the console prefixed with filename, function & line number
 A replacement for \_\_PRETTY_FUNCTION__
 
 - parameters:
     - msg: The message to print
     - function: The calling function or method (Defaults to #function)
     - file: The file containing function (Defaults to #file)
     - line: The line of the DLog call (Defaults to #line)
 */
func DLog(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
    let url = URL(fileURLWithPath: file)
    let className : String = url.lastPathComponent
    print("[\(className) \(function)](\(line)) \(msg)")
}

extension UIColor {
    /**
     Create colour from hex string.
     
     From [Stack Overflow](http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios)
     
     - parameter hexString: A hexadecimal string defining the colour
     */
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
