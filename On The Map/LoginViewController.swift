//
//  ViewController.swift
//  On The Map
//
//  Created by Azuka Omesiete on 7/29/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   

    @IBOutlet weak var usernameA: UITextField!
    @IBOutlet weak var passwordA: UITextField!
    
    var session: NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
   
    
    
    @IBAction func loginPressed(sender: AnyObject) {
       
        UDClient.sharedInstance().returnSessionID{result, error in
                print(result)
                
            }
        
    
        

    }
    private func completeLogin() {
     //   debugTextLabel.text = ""
        let controller = storyboard!.instantiateViewControllerWithIdentifier("MapViewController") as! UIViewController
        presentViewController(controller, animated: true, completion: nil)
    }

   
    
}

