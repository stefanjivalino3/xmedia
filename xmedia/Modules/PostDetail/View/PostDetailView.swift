//  
//  PostDetailView.swift
//  xmedia
//
//  Created by Personal on 29/01/22.
//

import UIKit

class PostDetailView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var countCommentsLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
//    @IBOutlet weak var firstViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var secondViewHeight: NSLayoutConstraint!
    // VARIABLES HERE
    var viewModel = PostDetailViewModel()
    
    ///Data received
    var userId: Int = 0
    var postId:Int = 0
    var postName: String = ""
    var postUsername: String = ""
    var postTitle: String = ""
    var postBody: String = ""
    
    var dataComment: [PostDetailComment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupUI()
        self.setupStackViewHeight()
        
        ///Label click event
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(PostDetailView.userNameClicked))
        let usernameTap = UITapGestureRecognizer(target: self, action: #selector(PostDetailView.userNameClicked))

        nameLabel.addGestureRecognizer(nameTap)
        userNameLabel.addGestureRecognizer(usernameTap)
    }
    
    @objc func userNameClicked(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toUserDetail", sender: self)
    }
    
    func setupUI() {
        nameLabel.text = postName
        userNameLabel.text = postUsername
        titleLabel.text = postTitle
        bodyLabel.text = postBody
        
        self.commentsTableView.register(UINib.init(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        self.commentsTableView.dataSource = self
        self.commentsTableView.delegate = self
        self.commentsTableView.separatorStyle = .none
    }
    
    func setupStackViewHeight() {
        //SETUP FIRST VIEW
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        
        let titleHeight = postTitle.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 17, weight: .semibold))
        let bodyHeight = postBody.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 15, weight: .semibold))
        
        viewHeight.constant = CGFloat(titleHeight) + CGFloat(bodyHeight) + 180
        
        //SETUP SECOND VIEW **on didGetData -- refer to data collected
        
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
            self.dataComment = self.viewModel.comment
            self.commentsTableView.reloadData()
            
            //SETUP SECOND VIEW
            let screenRect = UIScreen.main.bounds
            let screenWidth = screenRect.size.width
            var secondViewHeightFlag:CGFloat = 0
            for item in self.dataComment {
                let name = item.name?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 13, weight: .regular))
                let body = item.body?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 14, weight: .semibold))
                
                let height = CGFloat(name ?? 0) + CGFloat(body ?? 0) + 85
                secondViewHeightFlag += height
            }
            
            self.secondViewHeight.constant = secondViewHeightFlag
        }
        
        self.viewModel.getDetailComment(id: postId)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserDetail" {
            let vc = segue.destination as! UserDetailView
            vc.userId = userId
        }
    }
}

extension PostDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        cell.nameLabel.text = dataComment[indexPath.row].name
        cell.bodyLabel.text = dataComment[indexPath.row].body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        var height: CGFloat = 0
        let name = dataComment[indexPath.row].name?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 13, weight: .regular))
        let body = dataComment[indexPath.row].body?.height(withConstrainedWidth: screenWidth-40, font: .systemFont(ofSize: 14, weight: .semibold))
        
        height = CGFloat(name ?? 0) + CGFloat(body ?? 0) + 85
        return height
    }
    
    
}


