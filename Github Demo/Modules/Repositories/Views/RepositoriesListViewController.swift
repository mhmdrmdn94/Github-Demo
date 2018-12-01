//
//  RepositoriesListViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class RepositoriesListViewController: BaseViewController {
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    weak var presenter: RespositoriesListPresenterProtocol?
    
    fileprivate let emptyStateView = GitEmptyStateView()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var searchTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadRepositories(usingSearchKey: "")
    }
}

fileprivate extension RepositoriesListViewController {
    fileprivate func setupView() {
        setupTableView()
        setupTableViewInfiniteScrolling()
        setupSearchController()
        initNavbarButtons()
    }
    
    func initNavbarButtons() {
        let logoutButton = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action:  #selector(logoutButtonTapped))
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItems = [logoutButton, filterButton]
    }
    
    @objc func logoutButtonTapped(sender: UIBarButtonItem) {
        if UserSessionManager.currentUser != nil {
            showLogoutAlert()
        }
    }
    
    @objc func filterButtonTapped(sender: UIBarButtonItem) {
        print("Filter button tapped ..")
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "Alert", message: "You wanna logout?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            UserSessionManager.logoutUser()
        }))
        present(alert, animated: true, completion: nil)
    }
}

fileprivate extension RepositoriesListViewController {
    var cells: [UITableViewCell.Type] {
        return [RepositoryTableViewCell.self]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        registerCells()
    }
    
    func registerCells() {
        cells.forEach { item in
            let cellName = String(describing: item)
            let nib = UINib(nibName: cellName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellName)
        }
    }
    
    func setupTableViewInfiniteScrolling(){
        self.tableView.addInfiniteScroll { [weak self] (tableView) in
            self?.presenter?.loadRepositories()
        }
        
        self.tableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            return true     //cuz no last-page indicator in gethub response!
        }
    }
}

extension RepositoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getRepositoriesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter,
            let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self))
            as? RepositoryTableViewCell else {
                return UITableViewCell()
        }
        var viewModel = presenter.getViewModel(at: indexPath)
        viewModel.indexPath = indexPath
        cell.viewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.performSelectionActionForRepo(at: indexPath)
    }
}

fileprivate extension RepositoriesListViewController {
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for repository..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
    }
}

extension RepositoriesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if searchTimer != nil {
            searchTimer.invalidate()
        }
        if let searchKeyword = searchController.searchBar.text {
            searchTimer = Timer.scheduledTimer(timeInterval: 1,
                                               target: self,
                                               selector: #selector(self.searchForRepository),
                                               userInfo: searchKeyword, repeats: false)
        }
    }
    
    @objc private func searchForRepository() {
        if let searchKeyword = searchTimer.userInfo as? String {
            presenter?.loadRepositories(usingSearchKey: searchKeyword)
        }
        searchTimer.invalidate()
    }
}

extension RepositoriesListViewController: RespositoriesListViewProtocol {
    func showEmptyState(with type: GitEmptyStateType) {
        tableView.reloadData()
        emptyStateView.type = type
        emptyStateView.delegate = self
        tableView.backgroundView = emptyStateView
    }
    
    func reloadRepositories() {
        tableView.backgroundView = nil
        tableView.reloadData()
    }
}

extension RepositoriesListViewController: GitEmptyStateViewDelegate {
    func didTapActionButton() {
        presenter?.loadRepositories()
    }
}
