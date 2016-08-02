//
//  GCDBlackbox.swift
//  On The Map
//
//  Created by Azuka Omesiete on 7/30/16.
//  Copyright © 2016 Azuka Omesiete. All rights reserved.
//

import Foundation


func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}