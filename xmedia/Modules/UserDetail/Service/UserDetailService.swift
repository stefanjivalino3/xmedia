//
//  list-postService.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation
import Moya

enum UserDetailService {
    case getUserDetail(id:Int)
    case getUserAlbum(userId:String)
    case getPhotos(albumId: Int)
}

extension UserDetailService: TargetType {
    var path: String {
        switch self {
        case .getUserDetail(let id):
            return "users/\(id)"
        case .getUserAlbum:
            return "albums"
        case .getPhotos:
            return "photos"
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserDetail,
             .getUserAlbum,
             .getPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUserDetail:
            let parameter: [String: String] = [:]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .getUserAlbum(let userId):
            let parameter: [String: String] = [
                "userId" : userId]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .getPhotos(let albumId):
            let parameter: [String: String] = [
                "albumId" : String(albumId)
            ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept": "application/json"
        ]
    }
}
