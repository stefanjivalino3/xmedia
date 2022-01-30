//  
//  PhotoDetailView.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import UIKit

class PhotoDetailView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var photoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // VARIABLES HERE
    var viewModel = PhotoDetailViewModel()
    var photoTitle = ""
    var photoUrl = ""
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupUI()
        self.setupScrollView()
    }
    
    func setupUI() {
        if let firstName = self.name.components(separatedBy: " ").first {
            navigationItem.title = "\(firstName)'s Photo"
        }
        
        //SETUP IMAGE HEIGHT
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        photoViewHeight.constant = screenWidth
        //SET UI IMAGE
        photoImage.kf.setImage(with: URL(string: photoUrl), placeholder: nil, options: [.transition(.fade(0.5))], progressBlock: nil)
        
        //SET LABEL
        nameLabel.text = name
        titleLabel.text = photoTitle
    }
    
    func setupScrollView() {
        scrollView.delegate = self
    }
    
    fileprivate func setupViewModel() {

        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                 print("DATA READY")
            }
        }

        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }

        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }

        self.viewModel.didGetData = {
            // update UI after get data
        }

    }
}

extension PhotoDetailView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImage
    }
}


