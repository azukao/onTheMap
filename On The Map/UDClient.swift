//
//  UDClient.swift
//  On The Map
//
//  Created by Azuka Omesiete on 7/30/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation

class UDClient: NSObject {
    
    
    //shared session
    var session = NSURLSession.sharedSession()
    
    //configuration object
    //   var config =
    
    //authentication state
    var sessionID: String? = nil
    
    typealias UDCompletionHandler =
        (data: [String: AnyObject]?, errorString: String?) -> Void
    
    override init() {
        super.init()
    }
    
    //call function from Udacity to authenticate user
    func returnSessionID(username: String, password: String, completionHandler: UDCompletionHandler) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")! )
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) in
            
            if let error = error  {
                completionHandler(data: nil, errorString: error.localizedDescription)
                return
            }
            if let data = data {
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                self.parseLoginRequest(data: newData, completionHandler: completionHandler)
            } else {
                completionHandler(data: nil, errorString: "Login Error: Unable to retrieve data")
            }
        }; task.resume()
    }
    
    //function that parses the JSON received from udacity
    func parseLoginRequest(data data: NSData, completionHandler: UDCompletionHandler) {
        do{
            let parsedData =
                try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            if let parsedData = parsedData {
                if let errorString = parsedData["error"] as? String {
                    completionHandler(data: nil, errorString: errorString)
                    return
                }
                if let parsedData = parsedData["account"] as? [String: AnyObject] {
                    
                } else {
                    completionHandler(data: nil, errorString:"No Udacity Account found")
                }
            } else {
                completionHandler(data: nil, errorString: "Unable to parse data")
            }
        } catch let error as NSError{
            completionHandler(data: nil, errorString: "Login Error: \(error.localizedDescription)")
        }
    }
    
    //call function to retrieve other students location from cloud
    func getStudentLocations(completionHandler: UDCompletionHandler) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error == error  { // Handle error...
                completionHandler(data: nil, errorString: error!.localizedDescription)
                return
            }
            if data == data {
                self.parseStudentLocations(data: data!, completionHandler: completionHandler)
            } else { completionHandler(data: nil, errorString: "Login Error")
            }
        }
        task.resume()
    }
    
    //create function to parse locations JSON of other student that will be transfered to map view controller
    func parseStudentLocations(data data: NSData, completionHandler: UDCompletionHandler) {
        do{
            let parsedData =
                try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            
            if let parsedData = parsedData {
                if let errorString = parsedData["error"] as? String {
                    completionHandler(data: nil, errorString: errorString)
                    return
                }
                if let parsedData = parsedData["account"] as? [String: AnyObject] {
                    
                } else {
                    completionHandler(data: nil, errorString:"No Udacity Account found")
                }
            } else {
                completionHandler(data: nil, errorString: "Unable to parse data")
            }
        } catch let error as NSError{
            completionHandler(data: nil, errorString: "Login Error: \(error.localizedDescription)")
        }
    }
    
    //create singleton to be able to call method in a different swift file that it was created in through shared instance
    class func sharedInstance() -> UDClient {
        struct Singleton {
            static var sharedInstance = UDClient()
        }
        return Singleton.sharedInstance
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}