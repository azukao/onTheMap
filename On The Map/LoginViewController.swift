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
    
    func login() {
        var checkingDictionary = [String:AnyObject]()
        var checkingString = Bool()
        UDClient.sharedInstance().returnSessionID(usernameA.text!, password: passwordA.text!) {data, error in
            if data != nil {
                checkingDictionary = data!
                print(checkingDictionary)
                checkingString = checkingDictionary["registered"] as! Bool
                performUIUpdatesOnMain() {
                if checkingString == true {
                    print("Not Ready")
                    self.completeLogin()
                    }
                }
            }
        }
    }
    
    //function to complete login once user has been authenticated
    func completeLogin() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapViewController")
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    //call function for when login button is pressed
    @IBAction func loginPressed(sender: AnyObject) {
        self.login()
    }

    
    //to collapse keyboard after typing
    func keyboardDidShow(notification: NSNotification){
        if let info:NSDictionary = notification.userInfo {
            let keyboardSize =
                (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            let keyboardHeight = keyboardSize.height
            self.view.frame.origin.y = -(keyboardHeight)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        usernameA.resignFirstResponder()
        passwordA.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if usernameA.isFirstResponder() && passwordA.text!.isEmpty == false{
            passwordA.becomeFirstResponder()
        } else if passwordA.isFirstResponder() && !passwordA.text!.isEmpty {
            login()
        } else {
            passwordA.resignFirstResponder()
            usernameA.resignFirstResponder()
        }
        return false
    }
    
}


