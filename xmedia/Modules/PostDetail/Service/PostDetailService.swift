//
//  list-postService.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation
import Moya

enum PostDetailService {
    case getCommentDetail(id:Int)
}

extension PostDetailService: TargetType {
    var path: String {
        switch self {
        case .getCommentDetail(let id):
            return "posts/\(id)/comments"
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var method: Moya.Method {
        switch self {
        case .getCommentDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCommentDetail:
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
