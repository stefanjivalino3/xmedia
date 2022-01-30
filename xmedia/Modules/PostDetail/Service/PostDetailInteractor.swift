//
//  list-postInteractor.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation
import Moya

struct PostDetailInteractor {
    typealias getPostDetailCommentsCompletion = (([PostDetailComment]?, Error?) -> Void)
    
    let provider = MoyaProvider<PostDetailService>()
    
    func getPostDetailComments(id: Int, completion: getPostDetailCommentsCompletion?) {
        provider.request(.getCommentDetail(id: id)) { (result) in
            switch result {
            case .success(let response):
                self.getPostDetailCommentsResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

extension PostDetailInteractor {
    private func getPostDetailCommentsResponse(_ response: Moya.Response, completion: getPostDetailCommentsCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            
            if let arrayData = json as? [String: Any] {
                let data1 = PostDetailComment(dictionary: arrayData)
                completion?([data1],nil)
            }
            else if let objData = json as? [[String: Any]] {
                let data2 = objData.map({ PostDetailComment(dictionary: $0)})
                completion?(data2, nil)
            }
        } catch {
            completion?(nil, error)
        }
    }
}

