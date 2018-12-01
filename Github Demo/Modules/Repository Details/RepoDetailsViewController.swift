//
//  RepoDetailsViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

class RepoDetailsViewController: BaseViewController {

    @IBOutlet weak fileprivate var topContainerView: UIView!
    @IBOutlet weak fileprivate var descriptionLabel: UILabel!
    @IBOutlet weak fileprivate var avatarImageView: UIImageView!
    @IBOutlet weak fileprivate var forksTableView: UITableView!
    @IBOutlet weak fileprivate var bottomContainerView: UIView!
    @IBOutlet weak fileprivate var numberOfForksLabel: UILabel!
    @IBOutlet weak fileprivate var numberOfWatchersLabel: UILabel!
    
    var repository: Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    func setupView() {
        topContainerView.roundCorners(withRadius: 10)
        bottomContainerView.roundCorners(withRadius: 10)
        numberOfForksLabel.textColor = GitColor.darkBlue.value
        numberOfWatchersLabel.textColor = GitColor.darkBlue.value
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: GitColor.darkBlue.value]
        
        navigationItem.title = repository?.name ?? "Name N/A"
        descriptionLabel.text = repository?.repoDescription ?? "Description N/A"
        numberOfWatchersLabel.text = repository?.numberOfWatchers?.description ?? "0 watcher"
        numberOfForksLabel.text = repository?.numberOfForks?.description ?? "0 fork"
        let url = URL(string: (repository?.ownerAvatar)!)
        avatarImageView.sd_setImage(with: url!,
                                         placeholderImage: #imageLiteral(resourceName: "Octocat"),
                                         completed: nil)
    }
    
}

fileprivate extension RepoDetailsViewController {
    var cells: [UITableViewCell.Type] {
        return [UITableViewCell.self]
    }
    
    func setupTableView() {
        forksTableView.delegate = self
        forksTableView.dataSource = self
        forksTableView.estimatedRowHeight = 200
        forksTableView.rowHeight = UITableViewAutomaticDimension
        registerCells()
    }
    
    func registerCells() {
        cells.forEach { item in
            let cellName = String(describing: item)
            let nib = UINib(nibName: cellName, bundle: nil)
            forksTableView.register(nib, forCellReuseIdentifier: cellName)
        }
    }
    
//    func setupTableViewInfiniteScrolling(){
//        self.tableView.addInfiniteScroll { [weak self] (tableView) in
//            self?.presenter?.loadRepositories()
//        }
//
//        self.tableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
//            return true     //cuz no last-page indicator in gethub response!
//        }
//    }
}

extension RepoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
