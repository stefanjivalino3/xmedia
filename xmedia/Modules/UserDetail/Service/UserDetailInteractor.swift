//
//  UserDetailInteractor.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import Foundation
import Moya

struct UserDetailInteractor {
    typealias getUserDetailCompletion = ((UserDetailModel?, Error?) -> Void)
    typealias getUserAlbumCompletion = (([UserAlbum]?, Error?) -> Void)
    typealias getPhotosCompletion = (([Photos]?, Error?) -> Void)
    
    let provider = MoyaProvider<UserDetailService>()
    
    func getUserDetail(id: Int, completion: getUserDetailCompletion?) {
        provider.request(.getUserDetail(id: id)) { (result) in
            switch result {
            case .success(let response):
                self.getUserDetailResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func getUserAlbum(userId: String, completion: getUserAlbumCompletion?) {
        provider.request(.getUserAlbum(userId: userId)) { (result) in
            switch result {
            case .success(let response):
                self.getUserAlbumResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    func getPhotos(albumId: Int, completion: getPhotosCompletion?) {
        provider.request(.getPhotos(albumId: albumId)) { (result) in
            switch result {
            case .success(let response):
                self.getPhotosResponse(response, completion: completion)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
}

extension UserDetailInteractor {
    private func getUserDetailResponse(_ response: Moya.Response, completion: getUserDetailCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
            
            let data1 = UserDetailModel(dictionary: json)
            completion?(data1,nil)
            
        } catch {
            completion?(nil, error)
        }
    }
    
    private func getUserAlbumResponse(_ response: Moya.Response, completion: getUserAlbumCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            if let objData = json as? [[String: Any]] {
                let data2 = objData.map({ UserAlbum(dictionary: $0)})
                completion?(data2, nil)
            }
        } catch {
            completion?(nil, error)
        }
    }
    
    private func getPhotosResponse(_ response: Moya.Response, completion: getPhotosCompletion?) {
        do {
            let data = response.data
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            if let objData = json as? [[String: Any]] {
                let data2 = objData.map({ Photos(dictionary: $0)})
                completion?(data2, nil)
            }
        } catch {
            completion?(nil, error)
        }
    }
}
