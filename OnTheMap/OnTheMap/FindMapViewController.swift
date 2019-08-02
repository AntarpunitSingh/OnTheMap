//
//  FindMapViewController.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-08-02.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit
import MapKit
class FindMapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var locationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func location(_ sender: UIButton) {
    }
}
