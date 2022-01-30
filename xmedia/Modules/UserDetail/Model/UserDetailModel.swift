//  
//  UserDetailModel.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import Foundation

struct UserDetailModel: Mappables {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: UserAddress?
    let company: Company?
    
    init(dictionary: [String : Any]?) {
        self.id = dictionary?["id"] as? Int
        self.name = dictionary?["name"] as? String
        self.username = dictionary?["username"] as? String
        self.email = dictionary?["email"] as? String
        self.address = UserAddress(dictionary: dictionary?["address"] as? [String:Any])
        self.company = Company(dictionary: dictionary?["company"] as? [String:Any])
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = id { params["id"] = value }
        if let value = name { params["name"] = value }
        if let value = username { params["username"] = value }
        if let value = email { params["email"] = value }
        if let value = address { params["address"] = value }
        if let value = company { params["company"] = value }
        
        return params
    }
}

struct UserAddress: Mappables {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    
    init(dictionary: [String : Any]?) {
        self.street = dictionary?["street"] as? String
        self.suite = dictionary?["suite"] as? String
        self.city = dictionary?["city"] as? String
        self.zipcode = dictionary?["zipcode"] as? String
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = street { params["street"] = value }
        if let value = suite { params["suite"] = value }
        if let value = city { params["city"] = value }
        if let value = zipcode { params["zipcode"] = value }
        
        return params
    }
}

struct Photos: Mappables {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
    
    init(dictionary: [String : Any]?) {
        self.albumId = dictionary?["albumId"] as? Int
        self.id = dictionary?["id"] as? Int
        self.title = dictionary?["title"] as? String
        self.url = dictionary?["url"] as? String
        self.thumbnailUrl = dictionary?["thumbnailUrl"] as? String
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = albumId { params["albumId"] = value }
        if let value = id { params["id"] = value }
        if let value = title { params["title"] = value }
        if let value = url { params["url"] = value }
        if let value = thumbnailUrl { params["thumbnailUrl"] = value }
        
        return params
    }
}

struct UserAlbum: Mappables {
    let userId: Int?
    let id: Int?
    let title: String?
    
    init(dictionary: [String : Any]?) {
        self.userId = dictionary?["userId"] as? Int
        self.id = dictionary?["id"] as? Int
        self.title = dictionary?["title"] as? String
    }
    
    func dictionary() -> [String : Any] {
        var params: [String: Any] = [:]
        if let value = userId { params["userId"] = value }
        if let value = id { params["id"] = value }
        if let value = title { params["title"] = value }
        
        return params
    }
}
