//
//  UserProfile.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-08-02.
// Copyright © 2019 AntarpunitSingh. All rights reserved.


import Foundation
struct UserProfile: Codable {
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case key
    }
}
//import Foundation
//struct UserProfile:Codable {
//
//    var user: Profile
//}
//struct Profile:Codable {
//
//    var firstName : String
//    var lastName: String
//
//    enum CodingKeys : String ,CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//    }
//}
