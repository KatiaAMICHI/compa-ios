//
//  UserRepository.swift
//  compa
//
//  Created by m2sar on 14/05/2018.
//  Copyright © 2018 m2sar. All rights reserved.
//

import Foundation

class UserRepository {

    let http: HTTPService = HTTPService()

    
    func getFriends(result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        http.get(
            isRelative: true,
            isAuthenticated: true,
            url: "/friend/accepted",
            success: { data in
                result(Array(data.values).map { User(dictionary: $0 as! [String : Any])! } )
            },
        
            error: error
        )
        
    }
    
    func getBlocked(result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        http.get(
            isRelative: true,
            isAuthenticated: true,
            url: "/friend/blocked",
            success: { data in
              result(Array(data.values).map { User(dictionary: $0 as! [String : Any])! } )
            },
            
            error: error
        )
        
    }
    //request I have received
    func getPending(result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        http.get(
            isRelative: true,
            isAuthenticated: true,
            url: "/friend/pending",
            success: { data in
               result(Array(data.values).map { User(dictionary: $0 as! [String : Any])! } )
            },
            
            error: error
        )
        
    }
    
    //request I have made
    func getAwaiting(result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        http.get(
            isRelative: true,
            isAuthenticated: true,
            url: "/friend/awaiting"
            ,
            success: { data in
                result(Array(data.values).map { User(dictionary: $0 as! [String : Any])! } )
            },
            
            error: error
        )
        
    }
    
    
    func get(identifier:String, result: @escaping (_ data: User )->Void, error: @escaping (_ data: [String:Any] )->Void ) {
        var url = "/user"
        
        if(identifier != "") {
            url += "/" + identifier
        }
        
        http.get(
            isRelative: true,
            isAuthenticated: true,
            url: url,
            success: { data in
                result(User(dictionary:data)!)
            },
            
            error: error
        )
        
    }

    func update( object: User, result: @escaping (_ data: Bool )->Void, error: @escaping (_ data: [String:Any] )->Void ) {
        result(true)
    }

    func delete( object: User, result: @escaping (_ data: Bool )->Void, error: @escaping (_ data: [String:Any] )->Void  ) {
        result(true)
    }
    
    func getAuthUser(result: @escaping (_ data: User )->Void, error: @escaping (_ data: [String:Any] )->Void ){
        get(identifier: "", result:result, error:error)
    }
    
    func search(text:String, result: @escaping (_ data: [User] )->Void, error: @escaping (_ data: [String:Any] )->Void){
        
        var components = URLComponents()
        components.path = "/friend/search"
        components.queryItems = [URLQueryItem(name:"tag", value: text)]
        let url = components.url!.relativeString
        
        http.get(
            isRelative: true,
            isAuthenticated: true,
            url: url,
            success: { data in
                result(Array(data.values).map { User(dictionary: $0 as! [String : Any])! } )
            },
            
            error: error
        )
    }
    
    
    func resetPassword(email:String, result: @escaping (_ data: [String:Any] )->Void, error: @escaping (_ data: [String:Any] )->Void){
        
        http.post(
            isRelative: true,
            isAuthenticated: true,
            url: "/forgotPassword",
            data: ["email" : email],
            success: result,
            error: error
        )
    }
    
    func setGhostMode(ghostMode: Bool, result: @escaping (_ data: [String:Any] )->Void, error: @escaping (_ data: [String:Any] )->Void) {
        http.put(isRelative: true,
                 isAuthenticated: true,
                 url: "/user/ghostmode",
                 data: ["mode" : ghostMode],
                 success: result,
                 error: error
        )
    }
    

    
}

