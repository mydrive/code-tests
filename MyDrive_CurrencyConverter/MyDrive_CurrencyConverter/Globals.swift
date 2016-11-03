//
//  Globals.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 03/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

import Foundation

let defaultURLString : String = "https://raw.githubusercontent.com/mydrive/code-tests/master/iOS-currency-exchange-rates/rates.json"

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
