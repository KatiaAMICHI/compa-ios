//
//  UserRepository.swift
//  compa
//
//  Created by m2sar on 14/05/2018.
//  Copyright © 2018 m2sar. All rights reserved.
//

import Foundation

class UserRepository {
    
    //TODO reprendre le code de APIRequest pour envoyer la photo et modifié le 'body = data' en parsant l'image.
    //CF https://stackoverflow.com/questions/16434537/post-image-to-server-in-iphone

    let http: HTTPService = HTTPService()

    
    func getFriends(imageSize: Int? = nil, result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {

        let url = urlWithSize(imageSize: imageSize, url: "/friend/accepted")
        
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
    
    func getBlocked(imageSize: Int? = nil, result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        let url = urlWithSize(imageSize: imageSize, url: "/friend/blocker")
        
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
    //request I have received
    func getPending(imageSize: Int? = nil, result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        let url = urlWithSize(imageSize: imageSize, url: "/friend/pending")
        
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
    
    //request I have made
    func getAwaiting(imageSize: Int? = nil, result: @escaping (_ data: [User]) -> Void, error: @escaping (_ data: [String:Any] )->Void ) {
        
        let url = urlWithSize(imageSize: imageSize, url: "/friend/awaiting")
        
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
    
    
    func get(imageSize: Int? = nil, identifier:String, result: @escaping (_ data: User )->Void, error: @escaping (_ data: [String:Any] )->Void ) {
        var url = "/user"
        
        if(identifier != "") {
            url += "/" + identifier
        }
        
        url = urlWithSize(imageSize: imageSize, url: url)
        
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
    
    func getAuthUser(imageSize : Int? = nil, result: @escaping (_ data: User )->Void, error: @escaping (_ data: [String:Any] )->Void ){
        get(imageSize: imageSize, identifier: "", result:result, error:error)
    }
    
    private func urlWithSize(imageSize : Int? = nil, url:String) -> String {
        if let size = imageSize {
            var components = URLComponents()
            components.path = url
            components.queryItems = [URLQueryItem(name:"image_size", value: String(size))]
            return components.url!.relativeString
        }
        return url;
    }
    
    
   

    

    func updateProfile(name: String, email: String, result: @escaping (_ data: [String:Any] )->Void, error: @escaping (_ data: [String:Any] )->Void ) {
        http.put(isRelative: true,
                 isAuthenticated: true,
                 url: "/user/updateProfile",
                 data: ["name": name, "email": email],
                 success: result,
                 error: error)
    }

    func delete( object: User, result: @escaping (_ data: Bool )->Void, error: @escaping (_ data: [String:Any] )->Void  ) {
        result(true)
    }
    
    func search(imageSize: Int? = nil, text:String, result: @escaping (_ data: [User] )->Void, error: @escaping (_ data: [String:Any] )->Void){
        
        var components = URLComponents()
        components.path = "/friend/search"
        components.queryItems = [URLQueryItem(name:"tag", value: text)]
        let url = urlWithSize(imageSize: imageSize, url: components.url!.relativeString)
        
        
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
    
    

    func photo(image: NSData, result: @escaping (_ data: [String:Any] )->Void, error: @escaping (_ data: [String:Any] )->Void){
        
        http.postImage(
            isRelative: true,
            isAuthenticated: true,
            url: "/user/uploadPic",
            data: image,
            success: result,
            error: error)
    }
    
}

