//
//  list-postViewModel.swift
//  xmedia
//
//  Created by Personal on 28/01/22.
//

import Foundation

class PostListViewModel {
    
    private let service = PostListInteractor()
    
    private var model: [listPostModel] = [listPostModel]() {
        didSet {
            self.count = self.model.count
            self.data = self.model
        }
    }
    
    private var userModel: [UserModel] = [UserModel]() {
        didSet {
            self.userPost = self.userModel
        }
    }
    
    private var commentModel: [Comments] = [Comments]() {
        didSet {
            self.comments = self.commentModel
        }
    }
    
    
    /// Count your data in model
    var count: Int = 0
    var data: [listPostModel] = []
    var userPost: [UserModel] = []
    var comments: [Comments] = []
    
    //MARK: -- Network checking
    
    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()
    
    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }
    
    //MARK: -- UI Status
    
    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    var didGetUserPostData: (() -> ())?
    var didGetCommentData: (() -> ())?
    
    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    
    //MARK: -- Example Func
    func getListPost() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            // call your service here
            self.service.getListPost() { response, error in
                if let response = response {
                    self.data = response
                    
                    self.service.getUser() { response, error in
                        if let response = response {
                            self.userPost = response
                            
                            self.isLoading = false
                            self.didGetUserPostData?()
                        }
                    }
                    self.didGetData?()
                }
            }
        default:
            break
        }
    }
    
    func getCommentCount() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            // call your service here
            self.service.getAllComment() { response, error in
                if let response = response {
                    self.comments = response
                    self.didGetCommentData?()
                }
            }
        default:
            break
        }
    }
    
}

extension PostListViewModel {
    
}
