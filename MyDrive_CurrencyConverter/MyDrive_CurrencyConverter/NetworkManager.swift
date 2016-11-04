//
//  NetworkManager.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 03/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

import Foundation

class NetworkManager {
    
    /**
     HTTP request method
     */
    enum Method: String {
        case GET, POST, PUT, DELETE
    }
    
    let defaultSession : URLSession
    
    /**
     Create a shared instance to initialise class as a singleton
     Originally taken from: [krakendev](http://krakendev.io/blog/the-right-way-to-write-a-singleton)
     */
    static let sharedInstance = NetworkManager()
    fileprivate init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300.0
        
        self.defaultSession = URLSession(configuration: configuration)
    }
    
    /**
     Handles a URLRequest of whatever type
     
     - parameters:
         - request: The URL request
         - completion: A method to handle the returned data
     */
    fileprivate func handleRequest (request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task : URLSessionDataTask = defaultSession.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
    
    /**
     Makes an HTTP request with the provided parameters
     
     - parameters:
         - method: The method for the request
         - params: The parameters for the request
         - completion: A method to handle the returned data
     */
    fileprivate func makeRequest (method: Method, params: Dictionary<String, AnyObject>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        if var urlComponents = URLComponents(string: urlString) {
            
            var requestParams: [URLQueryItem] = []
            
            for (paramName, paramValue) in params {
                requestParams.append(URLQueryItem(name: paramName, value: paramValue as? String))
            }
            
            urlComponents.queryItems = requestParams
            
            if let url : URL = urlComponents.url {
                var request : URLRequest = URLRequest(url: url)
                request.httpMethod = method.rawValue
                handleRequest(request: request, completion: completion)
            } else {
                DLog("Could not obtain URL from \(urlComponents.debugDescription)")
            }
        } else {
            DLog("Could not construct URLComponents from \(urlString)")
        }
    }
    
    /**
     Calls a request with the GET method
     
     - parameters:
         - params: The parameters for the GET request
         - urlString: the URL string
         - completion: A method to handle the returned data
     */
    func getRequest (params: Dictionary<String, AnyObject>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        makeRequest(method: .GET, params: params, urlString: urlString, completion: completion)
    }
    
    /**
     Calls a request with the POST method
     
     - parameters:
         - params: The parameters for the POST request
         - urlString: the URL string
         - completion: A method to handle the returned data
     */
    func postRequest (params: Dictionary<String, AnyObject>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        makeRequest(method: .POST, params: params, urlString: urlString, completion: completion)
    }
    
    /**
     Calls a request with the DELETE method
     
     - parameters:
         - params: The parameters for the DELETE request
         - urlString: the URL string
         - completion: A method to handle the returned data
     */
    func deleteRequest (params: Dictionary<String, AnyObject>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        makeRequest(method: .DELETE, params: params, urlString: urlString, completion: completion)
    }
}
