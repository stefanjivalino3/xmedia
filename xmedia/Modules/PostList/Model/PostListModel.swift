//
//  list-postModel.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation

protocol Mappables {
    init(dictionary: [String: Any]?)
    func dictionary() -> [String: Any]
}

struct listPostModel: Mappables {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    init(dictionary: [String : Any]?) {
        self.userId = dictionary?["userId"] as? Int
        self.id = dictionary?["id"] as? Int
        self.title = dictionary?["title"] as? String
        self.body = dictionary?["body"] as? String
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = userId { params["userId"] = value }
        if let value = id { params["id"] = value }
        if let value = title { params["title"] = value }
        if let value = body { params["body"] = value }
        
        return params
    }
}

struct UserModel: Mappables {
    let id: Int?
    let name: String?
    let username: String?
    let company: Company?
    
    init(dictionary: [String : Any]?) {
        self.id = dictionary?["id"] as? Int
        self.name = dictionary?["name"] as? String
        self.username = dictionary?["username"] as? String
        self.company = Company(dictionary: dictionary?["company"] as? [String:Any])
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = id { params["id"] = value }
        if let value = name { params["name"] = value }
        if let value = username { params["username"] = value }
        if let value = company { params["company"] = value }
        
        return params
    }
}

struct Company: Mappables {
    let name: String?
    
    init(dictionary: [String : Any]?) {
        self.name = dictionary?["name"] as? String
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = name { params["name"] = value }
        
        return params
    }
}

struct Comments: Mappables {
    let postId: Int?
    
    init(dictionary: [String : Any]?) {
        self.postId = dictionary?["postId"] as? Int
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = postId { params["postId"] = value }
        
        return params
    }
}

struct listPostUserModel {
    let postTitle: String?
    let postBody: String?
    let postUserName: String?
    let postCompany: String?
}



