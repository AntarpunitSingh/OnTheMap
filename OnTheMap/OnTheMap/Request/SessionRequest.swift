//
//  SessionRequest.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-07-29.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation
struct SessionRequest: Codable {
    var udacity: UdacityUserPass
    
    struct UdacityUserPass: Codable {
        var username: String
        var password: String
    }
}
