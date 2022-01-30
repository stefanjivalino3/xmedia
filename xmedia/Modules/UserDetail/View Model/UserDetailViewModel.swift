//  
//  UserDetailViewModel.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import Foundation

class UserDetailViewModel {

    private let service = UserDetailInteractor()
    private var model: [UserDetailModel] = [UserDetailModel]() {
        didSet {
            self.count = self.model.count
            self.userData = self.model
        }
    }
    
    private var albumModel: [UserAlbum] = [UserAlbum]() {
        didSet {
            self.albumData = self.albumModel
        }
    }
    
    private var photosModel: [Photos] = [Photos]() {
        didSet {
            self.photosData = self.photosModel
        }
    }

    /// Count your data in model
    var count: Int = 0
    var userData: [UserDetailModel] = []
    var albumData: [UserAlbum] = []
    var photosData: [Photos] = []

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

    /// Define selected model
    var selectedObject: UserDetailModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    var didGetAlbumData: (() -> ())?
    var didGetPhotosData: (() -> ())?

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: --  Func
    func getUserDetail(id: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.service.getUserDetail(id: id) { response, error in
                if let response = response {
                    self.model = [response]
                    
                    self.isLoading = false
                    self.didGetData?()
                }
            }
        default:
            break
        }
    }
    
    func getUserAlbum(userId: String) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.service.getUserAlbum(userId: userId) { response, error in
                if let response = response {
                    self.albumModel = response
                    
                    self.isLoading = false
                    self.didGetAlbumData?()
                }
            }
        default:
            break
        }
    }
    
    func getPhotos(albumId: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.service.getPhotos(albumId: albumId) { response, error in
                if let response = response {
                    self.photosModel = response
                    
                    self.isLoading = false
                    self.didGetPhotosData?()
                }
            }
        default:
            break
        }
    }

}

extension UserDetailViewModel {

}
