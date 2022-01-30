//  
//  UserDetailView.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import UIKit

class UserDetailView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var albumTableView: UITableView!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var albumViewHeight: NSLayoutConstraint!
    
    // VARIABLES HERE
    var viewModel = UserDetailViewModel()
    var album:[UserAlbum] = []
    var photos:[Photos] = []
    
    // VARIABLES RECEIVED
    var userId: Int = 0
    
    //VARIABLES SENT
    var sendPhotoTitle = ""
    var sendPhotoUrl = ""
    var sendName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        setupUI()
    }
    
    func setupUI() {
        profileImageView.roundedImage()
        let image = self.profileImageView.image?.imageWithInsets(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        profileImageView.image = image
        
        self.albumTableView.register(UINib.init(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        self.albumTableView.dataSource = self
        self.albumTableView.delegate = self
        self.albumTableView.separatorStyle = .none
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
            //SETUP ADDRESS STRING
            let street = self.viewModel.userData.first?.address?.street ?? ""
            let suite = self.viewModel.userData.first?.address?.suite ?? ""
            let city = self.viewModel.userData.first?.address?.city ?? ""
            let zipcode = self.viewModel.userData.first?.address?.zipcode ?? ""
            
            
            self.navigationItem.title = self.viewModel.userData.first?.name ?? ""
            
            self.nameLabel.text = self.viewModel.userData.first?.name ?? ""
            self.emailLabel.text = self.viewModel.userData.first?.email ?? ""
            self.companyLabel.text = self.viewModel.userData.first?.company?.name ?? ""
            self.addressLabel.text = "\(street), \(suite), \(city), \(zipcode)"
            
            if let firstName = self.viewModel.userData.first?.name?.components(separatedBy: " ").first {
                self.firstNameLabel.text = "\(firstName)'s Album"
            }
            
            
            //SETUP ALBUM
            self.albumViewHeight.constant = (5 * 220) + 80
        }
        
        self.viewModel.didGetAlbumData = {
            self.album = self.viewModel.albumData
            for item in self.album {
                self.viewModel.getPhotos(albumId: item.id ?? 0)
            }
        }
        
        self.viewModel.didGetPhotosData = {
            self.photos = self.photos + self.viewModel.photosData
            self.albumTableView.reloadData()
        }
        
        self.viewModel.getUserDetail(id: userId)
        self.viewModel.getUserAlbum(userId: String(userId))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoDetail" {
            let vc = segue.destination as! PhotoDetailView
            vc.photoTitle = sendPhotoTitle
            vc.photoUrl = sendPhotoUrl
            vc.name = sendName
            
        }
    }
}

extension UserDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumCell
        cell.delegate = self
        
        cell.nameLabel.text = album[indexPath.row].title
        
        cell.photos = photos.filter() { $0.albumId == self.album[indexPath.row].id }
        cell.thumbnailCollectionView.reloadData()
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension UserDetailView: AlbumCellDelegate {
    func goToPhotoDetail(for cell: AlbumCell, url: String, title: String) {
        self.sendPhotoUrl = url
        self.sendPhotoTitle = title
        self.sendName = self.viewModel.userData.first?.name ?? ""
        
        performSegue(withIdentifier: "toPhotoDetail", sender: self)
    }
}


