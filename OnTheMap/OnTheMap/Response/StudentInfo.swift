//
//  StudentInfo.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-07-31.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation
struct StudentInfo:Codable {
    
    let createdAt:String
    let firstName:String
    let lastName :String
    let latitude: Float
    let longitude: Float
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
