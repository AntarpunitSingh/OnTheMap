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
        static var sessionId = ""
        static var userId = ""
        static var objectId = ""
        static var userFirstName = ""
        static var userLastName = ""
        static var key = ""
    }
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case session
        case studentLocations(String)
        case postStudentLoc
        case getStudentInfo(String)
        
        var stringValue:String {
            switch self {
            case .session:
                return Endpoints.base + "/session"
            case .studentLocations(let value):
                return Endpoints.base + "/StudentLocation" + "?limit=100" + "&order=\(value.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? "")"
            case .postStudentLoc:
                return Endpoints.base + "/StudentLocation"
            case .getStudentInfo(let id):
                return Endpoints.base + "/users/" + "\(id)"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    class func taskGetRequest<responseType:Decodable>(url : URL,responseType: responseType.Type, completion: @escaping(responseType? ,Error?)->Void){
        let taskForGet = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            do {
                let decode = try JSONDecoder().decode(responseType.self, from: data)
                DispatchQueue.main.async {
                    completion(decode , nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
        taskForGet.resume()
    }
    class func taskPostRequest<requestType:Encodable , responseType: Decodable>(url: URL, body:requestType , response:responseType.Type,  completion: @escaping(responseType?,Error?)->Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil ,error)
                return }
            let range = Range(uncheckedBounds: (5,data.count))
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                
                let response = try decoder.decode(responseType.self, from: newData)
                completion(response,nil)
            }
            catch {
                completion(nil ,error )
            }
        }
        task.resume()
        
    }
    class func requestSession(username:String , password:String , completion: @escaping(Bool , Error?) -> Void ){
        taskPostRequest(url: Endpoints.session.url, body: SessionRequest(udacity: SessionRequest.UdacityUserPass(username: username, password: password)), response: SessionResponse.self) { (response, error) in
            if let response = response {
                Auth.userId = response.account.key
                Auth.sessionId = response.session.id
                completion(true , nil)
            }
            else{
                completion(false,error)
            }
        }

    }
    class func getStudentLocations(completion: @escaping([StudentInfo]?,Error?) -> Void){
        taskGetRequest(url: Endpoints.studentLocations("-updatedAt").url, responseType: StudentLocations.self) { (response,error ) in
            if let response = response {
                completion(response.results,nil)
            }
            else {
                completion(nil ,error)
            }
        }
    }
    class func getUserInfo(completion: @escaping(UserProfile?,Error?)-> Void){
        let taskForGet = URLSession.shared.dataTask(with: Endpoints.getStudentInfo(Auth.userId).url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            let range = Range(uncheckedBounds: (5,data.count))
            let newData = data.subdata(in: range)
            do {
                let decode = try JSONDecoder().decode(UserProfile.self, from: newData)
                DispatchQueue.main.async {
                    completion(decode , nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
        taskForGet.resume()
    }
    class func logoutRequest(completion:@escaping(Bool,Error?)->Void){
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                completion(true,nil)
                Auth.sessionId = ""
                Auth.userId = ""
                
            }
            else {
                completion(false,error)
            }
            
        }
        task.resume()
    }
    class func postStudentLocation(body: PostStudentLoc , completion: @escaping(Bool?,Error?) -> Void){
        var request = URLRequest(url: Endpoints.postStudentLoc.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                 DispatchQueue.main.async {
                  completion(false , error)
                }
                return}
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(PostStudentResponse.self, from: data)
                Auth.objectId = response.objectId
                DispatchQueue.main.async {
                     completion(true ,nil)
                }
            }
            catch {
                 DispatchQueue.main.async {
                  completion(false , error)
                }
            }
        }
        task.resume()
    }
}
