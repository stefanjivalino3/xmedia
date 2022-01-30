//  
//  PostDetailModel.swift
//  xmedia
//
//  Created by Personal on 29/01/22.
//

import Foundation

struct PostDetailComment: Mappables {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
    
    init(dictionary: [String : Any]?) {
        self.postId = dictionary?["postId"] as? Int
        self.id = dictionary?["id"] as? Int
        self.name = dictionary?["name"] as? String
        self.email = dictionary?["email"] as? String
        self.body = dictionary?["body"] as? String
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = postId { params["postId"] = value }
        if let value = id { params["id"] = value }
        if let value = name { params["name"] = value }
        if let value = email { params["email"] = value }
        if let value = body { params["body"] = value }
        
        return params
    }
}
