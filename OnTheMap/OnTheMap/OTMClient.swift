//
//  OTMClient.swift
//  OnTheMap
//
//  Created by Antarpunit Singh on 2012-07-27.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation

class OTMClient {
    
    struct Auth {
        static var  sessionId = ""
        static var userId = ""
    }
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case session
        case studentLocations(String)
        
        var stringValue:String {
            switch self {
            case .session:
                return Endpoints.base + "/session"
            case .studentLocations(let value):
                return Endpoints.base + "/StudentLocation" + "?limit=100" + "&order=\(value.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? "")"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    class func requestSession(username:String , password:String , completion: @escaping(Bool , Error?) -> Void ){
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(SessionRequest(udacity: SessionRequest.UdacityUserPass(username: username, password: password)))
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(false ,error)
                return }
            let range = Range(uncheckedBounds: (5,data.count))
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                
            let response = try decoder.decode(SessionResponse.self, from: newData)
                Auth.sessionId = response.session.id
                Auth.userId = response.account.key
                completion(true,nil)
            }
            catch {
                completion(false ,error )
            }
        }
        task.resume()
    }
    class func getStudentLocations(completion: @escaping([StudentInfo]?,Error?) -> Void){
        
        let task = URLSession.shared.dataTask(with: Endpoints.studentLocations("-updatedAt").url) { (data, response, error) in
            guard let data = data else {
                 DispatchQueue.main.async {
                completion([],error)
                }
                return}
            do {
               
            let decode = try JSONDecoder().decode(StudentLocations.self, from: data)
                DispatchQueue.main.async {
                     completion(decode.results,nil)
                }
            
            }
            catch {
                 DispatchQueue.main.async {
                completion([],error)
                }
            }
        }
        task.resume()
    
    }
}
