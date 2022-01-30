//
//  list-postService.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation
import Moya

enum PostListService {
    case getListPost
    case getUser
    case getAllComment
}

extension PostListService: TargetType {
    var path: String {
        switch self {
        case .getListPost:
            return "posts"
        case .getUser:
            return "users"
        case .getAllComment:
            return "comments"
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var method: Moya.Method {
        switch self {
        case .getListPost,
             .getUser,
             .getAllComment:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getListPost:
            let parameter: [String: String] = [:]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .getUser:
            let parameter: [String: String] = [:]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        case .getAllComment:
            let parameter: [String: String] = [:]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept": "application/json"
        ]
    }
}
