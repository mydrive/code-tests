//
//  NetworkManager.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 03/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let defaultSession : URLSession
    
    /**
     Create a shared instance to initialise class as a singleton
     Originally taken from: http://krakendev.io/blog/the-right-way-to-write-a-singleton
     */
    static let sharedInstance = NetworkManager()
    fileprivate init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300.0
        
        self.defaultSession = URLSession(configuration: configuration)
    }
    
    /**
    Handles a URLRequest of whatever type

    This gives me the ability to expand the class to handle different request methods
    e.g. For RESTful API interaction

    - Parameter request:  The URL request
    - Parameter completion: A method to handle the returned data
    */
    func handleRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task : URLSessionDataTask = defaultSession.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
