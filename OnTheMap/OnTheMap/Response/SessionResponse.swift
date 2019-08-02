//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-07-29.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    var account: Account
    var session: Session
}
struct Account: Codable {
    var registered: Bool
    var key: String
}

struct Session: Codable {
    var id: String
    var expiration: String
}
