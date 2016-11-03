//
//  Globals.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 03/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

import Foundation

/**
 Prints a message to the console prefixed with filename, function & line number
 A replacement for \_\_PRETTY_FUNCTION__
 
 - Parameter msg: The message to print
 - Parameter function: The calling function or method (Defaults to #function)
 - Parameter file: The file containing function (Defaults to #file)
 - Parameter line: The line of the DLog call (Defaults to #line)
 */
func DLog(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
    let url = URL(fileURLWithPath: file)
    let className : String = url.lastPathComponent
    print("[\(className) \(function)](\(line)) \(msg)")
}
