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
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var searchTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadRepositories(usingSearchKey: "alamofire")
    }
}

fileprivate extension RepositoriesListViewController {
    var cells: [UITableViewCell.Type] {
        return [RepositoryTableViewCell.self]
    }
    
    fileprivate func setupView() {
        setupTableView()
        setupTableViewInfiniteScrolling()
        setupSearchController()
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
            self?.presenter?.loadRepositories(usingSearchKey: "alamofire")
        }
        
        self.tableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            return true     //cuz no last-page indicator!
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
        print("Row #\( indexPath.row ) is selected.")
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
    
    func isSearchBarEmpty() -> Bool {
        let isEmpty = searchController.searchBar.text?.isEmpty ?? true
        return isEmpty
    }
}

extension RepositoriesListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(">>>ended editing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(">>> cancel button tapped")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            //TODO: show empty state
            print("Showing empty state")
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchTimer != nil {
            searchTimer.invalidate()
        }
        if let searchKeyword = searchController.searchBar.text, !searchKeyword.isEmpty {
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
    func reloadRepositories() {
        tableView.reloadData()
    }
    
    func showLoader() {
        Activity.showLoader()
    }
    
    func hideLoader() {
        Activity.hideLoader()
    }
    
    func showErrorMessage(_ message: String) {
        Alert.show(message: message)
    }
}
