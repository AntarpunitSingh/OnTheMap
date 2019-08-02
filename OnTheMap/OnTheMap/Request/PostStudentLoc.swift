//
//  PostStudentLoc.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-08-02.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation
struct PostStudentLoc: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}
