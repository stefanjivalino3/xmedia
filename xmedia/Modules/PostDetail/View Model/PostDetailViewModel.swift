//  
//  PostDetailViewModel.swift
//  xmedia
//
//  Created by Personal on 29/01/22.
//

import Foundation

class PostDetailViewModel {
    private let service = PostDetailInteractor()

    private var model: [PostDetailComment] = [PostDetailComment]() {
        didSet {
            self.count = self.model.count
            self.comment = self.model
        }
    }

    /// Count your data in model
    var count: Int = 0
    var comment: [PostDetailComment] = []

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


    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: -- Example Func
    func getDetailComment(id: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.service.getPostDetailComments(id: id) { response, error in
                if let response = response {
                    self.model = response
                    
                    self.isLoading = false
                    self.didGetData?()
                }
            }
        default:
            break
        }
    }

}

extension PostDetailViewModel {

}
