//
//  DataHandler.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 03/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

import Foundation

class DataHandler {
    var dollarValues: Dictionary<String, Float> = ["USD" : 1.0]
    
    static let sharedInstance = DataHandler()
    fileprivate init() {}
    
    /**
     Converts a raw data object to JSON, which is then passed to populateResults
     
     - parameter newData: The raw data object
     */
    func newData (newData: Data) {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: newData, options: .mutableLeaves)
            self.populateResults(jsonData: jsonData as AnyObject)
        } catch {
            DLog("JSON conversion error: \(error)")
        }
    }
    
    /**
     Separates a JSON Array into JSON Dictionary objects
     Passes each object through extractValuesFromJSON before adding to searchResults property

     - parameter jsonData: The JSON data object
     */
    func populateResults (jsonData: AnyObject) {
        if jsonData is NSDictionary {
            if let allObjects = jsonData["conversions"] as? NSArray {
                for object in allObjects {
                    if object is NSDictionary {
                        let conversionObject : Dictionary = extractValuesFromJSON(object: object as! NSDictionary, values: ["from", "rate", "to"])
                        convertConversionObjectToDollarRate(conversionObject: conversionObject)
                    } else {
                        DLog("object is not NSDictionary")
                    }
                }
                DLog("dollarValues:\n\(dollarValues)")
            } else {
                DLog("Cannot convert conversions to NSArray")
            }
        } else {
            DLog("jsonData is not NSDictionary")
        }
    }
    
    /**
     Converts rate conversion objects to dollar rates
     
     - parameter conversionObject: A rate conversion object
     */
    func convertConversionObjectToDollarRate (conversionObject: Dictionary<String, AnyObject>) {
        if let
            from = conversionObject["from"] as? String,
            let to = conversionObject["to"] as? String,
            let rate = conversionObject["rate"] as? Float
        {
            if from == "USD" {
                dollarValues[to] = rate
            } else if to == "USD" {
                dollarValues[from] = 1/rate
            }
        }
    }
    
    /**
     Extracts key/value pairs from a JSON dictionary

     - parameters:
         - object: The JSON dictionary
         - values: The keys to extract with their values

     - returns: A Dictionary containing the key/value pairs extracted
     */
    func extractValuesFromJSON (object: AnyObject, values: Array<String>) -> Dictionary<String, AnyObject> {
        var result: [String: AnyObject] = [:]
        for elementName in values {
            if let itemStr = object[elementName] as? String {
                result.updateValue(itemStr as AnyObject, forKey: elementName)
            } else if let itemFloat = object[elementName] as? Float {
                result.updateValue(itemFloat as AnyObject, forKey: elementName)
            } else {
                // Assume element doesn't exist
            }
        }
        if result.count < 1 {
            DLog("No values extracted from object:\n\(object)")
        }
        return result
    }
}
