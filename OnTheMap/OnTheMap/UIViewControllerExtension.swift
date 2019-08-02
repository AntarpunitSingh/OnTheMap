//
//  UIViewControllerExtension.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-08-01.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        OTMClient.logoutRequest { (success, error) in
            DispatchQueue.main.async {
               self.dismiss(animated: true, completion: nil)
                print("Session is\(OTMClient.Auth.userId)")
            }
        }
    }
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
    }
}
