//
//  RepoDetailsViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class RepoDetailsViewController: BaseViewController {

    @IBOutlet weak fileprivate var topContainerView: UIView!
    @IBOutlet weak fileprivate var descriptionLabel: UILabel!
    @IBOutlet weak fileprivate var avatarImageView: UIImageView!
    @IBOutlet weak fileprivate var forksTableView: UITableView!
    @IBOutlet weak fileprivate var bottomContainerView: UIView!
    @IBOutlet weak fileprivate var numberOfForksLabel: UILabel!
    @IBOutlet weak fileprivate var numberOfWatchersLabel: UILabel!
    
    var presenter: RepoDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        presenter?.loadRepositoryDetails()
        presenter?.loadForks()
    }
    
    private func setupView() {
        [topContainerView, bottomContainerView, forksTableView, avatarImageView].forEach { (view) in
            view?.roundCorners(withRadius: 10)
        }
        
        numberOfForksLabel.textColor = GitColor.darkBlue.value
        numberOfWatchersLabel.textColor = GitColor.darkBlue.value
    }
    
    fileprivate func populateRepoDetails(with viewModel: RepositoryViewModel) {
        navigationItem.title = viewModel.name
        descriptionLabel.text = viewModel.description
        numberOfWatchersLabel.text = viewModel.watchersString
        numberOfForksLabel.text = viewModel.forksString
        
        if let url = viewModel.ownerAvatar {
            avatarImageView.sd_setImage(with: url,
                                        placeholderImage: #imageLiteral(resourceName: "Octocat"),
                                        completed: nil)
        }
    }
}

fileprivate extension RepoDetailsViewController {
    var cells: [UITableViewCell.Type] {
        return [ForkTableViewCell.self]
    }
    
    func setupTableView() {
        forksTableView.delegate = self
        forksTableView.dataSource = self
        forksTableView.estimatedRowHeight = 200
        forksTableView.rowHeight = UITableViewAutomaticDimension
        registerCells()
        setupTableViewInfiniteScrolling()
    }
    
    func registerCells() {
        cells.forEach { item in
            let cellName = String(describing: item)
            let nib = UINib(nibName: cellName, bundle: nil)
            forksTableView.register(nib, forCellReuseIdentifier: cellName)
        }
    }
    
    func setupTableViewInfiniteScrolling(){
        self.forksTableView.addInfiniteScroll { [weak self] (tableView) in
            self?.presenter?.loadForks()
        }

        self.forksTableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            return true     //cuz no last-page indicator in gethub response!
        }
    }
}

extension RepoDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getForksCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter,
            let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing: ForkTableViewCell.self))
                as? ForkTableViewCell else {
                    return UITableViewCell()
        }
        
        var viewModel = presenter.getForkViewModel(at: indexPath)
        viewModel.indexPath = indexPath
        cell.viewModel = viewModel
        return cell
    }
}

extension RepoDetailsViewController: RepoDetailsViewProtocol {
    
    func showRepositoryDetails() {
        if let viewModel = presenter?.getRepositoryViewModel() {
            populateRepoDetails(with: viewModel)
        }
    }
    
    func reloadForksList() {
        forksTableView.backgroundView = nil
        forksTableView.reloadData()
        forksTableView.finishInfiniteScroll()
    }
    
    func showForksEmptyState(with type: GitEmptyStateType) {
        let emptyStateView = GitEmptyStateView()
        emptyStateView.delegate = self
        emptyStateView.type = type
        forksTableView.backgroundView = emptyStateView
    }
    
}

extension RepoDetailsViewController: GitEmptyStateViewDelegate {
    func didTapActionButton() {
        presenter?.loadForks()
    }
}
