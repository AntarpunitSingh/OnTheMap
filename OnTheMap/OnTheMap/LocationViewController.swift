//
//  LocationViewController.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-08-02.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit
import CoreLocation
class LocationViewController: UIViewController {

    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    var location = CLGeocoder()
    var lat : Double!
    var long: Double!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        }
    func geolocator(){
        location.geocodeAddressString(locationTextField.text!) { (placmark, error) in
            self.processResponse(withPlacemarks: placmark, error: error)
        
            
        }
    }


    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
    
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
        } else {
            var location: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            if let location = location {
                let coordinate = location.coordinate
                lat = coordinate.latitude
                long = coordinate.longitude
                print("\(lat ?? 9)" + "\(long ?? 9)")
            } else {
               print("No match found")
            }
        }
    }

    
    @IBAction func findAction(_ sender: Any) {
        OTMClient.getUserInfo { (user, error) in
            if let user = user {
                OTMClient.Auth.userFirstName = user.firstName
                OTMClient.Auth.userLastName = user.lastName
                OTMClient.Auth.key = user.key
            }
        }
        if locationTextField.text != nil || urlTextField.text != nil {
           geolocator()
            let body = PostStudentLoc(uniqueKey: OTMClient.Auth.key , firstName: OTMClient.Auth.userFirstName, lastName: OTMClient.Auth.userLastName, mapString: "punjab", mediaURL: "google.com", latitude: lat, longitude: long)
            OTMClient.postStudentLocation(body: body) { (success, error) in
                if let error = error {
                   print(error)
                }
            }
        }
    }
   
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
