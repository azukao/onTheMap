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
    
    override init() {
        super.init()
    }
    
    
    func returnSessionID(completionHandlerForPOST:(result: NSString!, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"aomesiete@gmail.com\", \"password\": \"mother86\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {data, response, error in
            var parsedResult: [String : AnyObject]!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
                var sessionId = "session id"
                
                completionHandlerForPOST(result: sessionId, error: nil)
                
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            }
        }
        
        task.resume()
    }

    
    
    //create singleton to be able to call method in a different swift file that it was created in through shared instance
    class func sharedInstance() -> UDClient {
        struct Singleton {
            static var sharedInstance = UDClient()
        }
        return Singleton.sharedInstance
    }
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}