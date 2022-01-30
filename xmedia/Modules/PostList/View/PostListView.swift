//  
//  PostListView.swift
//  xmedia
//
//  Created by Personal on 29/01/22.
//

import UIKit

class PostListView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var postTableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = PostListViewModel()
    var listPost:[listPostModel] = []
    var listUser:[UserModel] = []
    var listComments:[Comments] = []
    
    ///Data Passed to next page
    var sendUserId = 0
    var sendPostId = 0
    var sendPostName = ""
    var sendPostUserName = ""
    var sendPostTitle = ""
    var sendPostBody = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupUI()
    }
    
    
    func setupUI() {
        self.postTableView.register(UINib.init(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        self.postTableView.separatorStyle = .none
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo.pdf")
        imageView.image = image
        self.navigationItem.titleView = imageView
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
            self.listPost = self.viewModel.data
        }
        self.viewModel.didGetUserPostData = {
            self.listUser = self.viewModel.userPost
            self.postTableView.reloadData()
        }
        self.viewModel.didGetCommentData = {
            self.listComments = self.viewModel.comments
            self.postTableView.reloadData()
        }
        self.viewModel.getListPost()
        self.viewModel.getCommentCount()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let vc = segue.destination as! PostDetailView
            vc.userId = sendUserId
            vc.postId = sendPostId
            vc.postName = sendPostName
            vc.postTitle = sendPostTitle
            vc.postBody = sendPostBody
            vc.postUsername = sendPostUserName
        }
    }
}

extension PostListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        cell.nameLabel.text = self.viewModel.userPost.first { $0.id == self.listPost[indexPath.row].userId }?.name
        cell.usernameLabel.text = "@\(self.viewModel.userPost.first { $0.id == self.listPost[indexPath.row].userId }?.username ?? "")"
        cell.companyLabel.text = self.viewModel.userPost.first { $0.id == self.listPost[indexPath.row].userId }?.company?.name
        cell.titleLabel.text = listPost[indexPath.row].title
        cell.bodyLabel.text = listPost[indexPath.row].body
        
        let filtered = listComments.filter() { $0.postId ?? 0 == listPost[indexPath.row].id }
        cell.commentCountLabel.text = "\(filtered.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var x = 0
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        var height: CGFloat = 0
        
        
        for data in listPost {
            let bodyHeight = data.body?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 13, weight: .regular))
            let title = data.title?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 14, weight: .semibold))
            let name = self.viewModel.userPost.first { $0.id == data.userId }?.name?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 16, weight: .semibold))
            let bodyenter = data.body?.count(of: "\n") ?? 0 * 10
            if indexPath.row == x {
                height = CGFloat(bodyHeight ?? 0) + CGFloat(title ?? 0) + CGFloat(name ?? 0) + CGFloat(name ?? 0) + 140 + CGFloat(bodyenter )
            }
            x += 1
            
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendUserId = self.viewModel.userPost.first { $0.id == self.listPost[indexPath.row].userId }?.id ?? 0
        sendPostId = listPost[indexPath.row].id ?? 0
        sendPostTitle = listPost[indexPath.row].title ?? ""
        sendPostBody = listPost[indexPath.row].body ?? ""
        sendPostName = self.viewModel.userPost.first { $0.id == self.listPost[indexPath.row].userId }?.name ?? ""
        sendPostUserName = "@\(self.viewModel.userPost.first { $0.id == self.listPost[indexPath.row].userId }?.username ?? "")"
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    
}


