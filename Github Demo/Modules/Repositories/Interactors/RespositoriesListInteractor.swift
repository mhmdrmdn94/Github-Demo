//
//  RespositoriesListInteractor.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation

class RespositoriesListInteractor: RespositoriesListInteractorProtocol {
    var presenter: RespositoriesListInteractorOutputProtocol?
    
    fileprivate var repositories = [Repository]()
    fileprivate var currentPage = 1
    fileprivate var searchKeyword = ""
    
    func loadRepositories(usingSearchKey newKeyword: String) {
        if searchKeyword != newKeyword {
            searchKeyword = newKeyword
            repositories = []
            currentPage = 1
        }
        
        if searchKeyword.isEmpty {
            showEmptyState(withType: .noSearchKeywordLogged)
            return
        }
        
        fetchRepositories()
    }
    
    func loadRepositories() {
        fetchRepositories()
    }
    
    func getRepositoriesCount() -> Int {
        let count = repositories.count
        return count
    }
    
    func getViewModel(at indexPath: IndexPath) -> RepositoryTableViewCellViewModel {
        let repository = repositories[indexPath.row]
        let viewModel = constuctRepositoryViewModelFrom(repository)
        return viewModel
    }
    
    func getModel(at indexPath: IndexPath) -> Repository {
        let repository = repositories[indexPath.row]
        return repository
    }
    
    func performLogout() {
        //TODO:- logout current user
    }
}

fileprivate extension RespositoriesListInteractor {
    
    func fetchRepositories() {
        ReposService
            .search(keyword: searchKeyword,
                    page: currentPage,
                    onSuccess: { [weak self] (repositories) in
                        guard let strongSelf = self else { return }
                        
                        if repositories.isEmpty {
                            self?.showEmptyState(withType: .noResults)
                            self?.repositories = []
                            return
                        }
                        
                        if strongSelf.currentPage == 1 {
                            strongSelf.repositories = repositories
                        } else {
                            strongSelf.repositories.append(contentsOf: repositories)
                        }
                        strongSelf.currentPage = strongSelf.currentPage + 1
                        strongSelf.presenter?.didLoadRepositories()
                        
            }) { [weak self] (error) in
                let nserror = error as NSError
                if nserror.code == 1009 {
                    self?.showEmptyState(withType: .noInternetConnection)
                } else {
                    self?.showEmptyState(withType: .someThingWentWrong)
                }
        }
    }
    
    func showEmptyState(withType type: GitEmptyStateType) {
        let emptyStateViewModel = type.viewModel
        presenter?.showEmptyState(with: emptyStateViewModel)
    }
    
    func constuctRepositoryViewModelFrom(_ repository: Repository) -> RepositoryTableViewCellViewModel {
        let name = repository.name ?? "Name N/A"
        let description = repository.repoDescription ?? "Description N/A"
        let forks = repository.numberOfForks ?? 0
        let watchers = repository.numberOfWatchers ?? 0
        var avatarUrl: URL? = nil
        if let urlString = repository.ownerAvatar,
            let url = URL(string: urlString) {
            avatarUrl = url
        }
        
        let viewModel = RepositoryTableViewCellViewModel(name: name,
                                                         ownerAvatar: avatarUrl,
                                                         description: description,
                                                         numberOfForks: forks,
                                                         numberOfWatchers: watchers)
        return viewModel
    }
}
