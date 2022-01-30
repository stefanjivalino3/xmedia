//
//  list-postInteractor.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation
import Moya

struct PostListInteractor {
    typealias getListPostCompletion = (([listPostModel]?, Error?) -> Void)
    typealias getUserCompletion = (([UserModel]?, Error?) -> Void)
    typealias getAllCommentCompletion = (([Comments]?, Error?) -> Void)
    
    let provider = MoyaProvider<PostListService>()
    
    func getListPost(completion: getListPostCompletion?) {
        provider.request(.getListPost) { (result) in
            switch result {
            case .success(let response):
                self.getListPostResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func getUser(completion: getUserCompletion?) {
        provider.request(.getUser) { (result) in
            switch result {
            case .success(let response):
                self.getUserResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func getAllComment(completion: getAllCommentCompletion?) {
        provider.request(.getAllComment) { (result) in
            switch result {
            case .success(let response):
                self.getAllCommentResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

extension PostListInteractor {
    private func getListPostResponse(_ response: Moya.Response, completion: getListPostCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            
            if let arrayData = json as? [String: Any] {
                let data1 = listPostModel(dictionary: arrayData)
                completion?([data1],nil)
            }
            else if let objData = json as? [[String: Any]] {
                let data2 = objData.map({ listPostModel(dictionary: $0)})
                completion?(data2, nil)
            }
        } catch {
            completion?(nil, error)
        }
    }
    
    private func getUserResponse(_ response: Moya.Response, completion: getUserCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            
            if let arrayData = json as? [String: Any] {
                let data1 = UserModel(dictionary: arrayData)
                completion?([data1],nil)
            }
            else if let objData = json as? [[String: Any]] {
                let data2 = objData.map({ UserModel(dictionary: $0)})
                completion?(data2, nil)
            }
        } catch {
            completion?(nil, error)
        }
    }
    
    private func getAllCommentResponse(_ response: Moya.Response, completion: getAllCommentCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            
            if let arrayData = json as? [String: Any] {
                let data1 = Comments(dictionary: arrayData)
                completion?([data1],nil)
            }
            else if let objData = json as? [[String: Any]] {
                let data2 = objData.map({ Comments(dictionary: $0)})
                completion?(data2, nil)
            }
        } catch {
            completion?(nil, error)
        }
    }
}

