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
    
    func loadRepositories(usingSearchKey keyword: String) {
        searchKeyword = keyword
        if searchKeyword.isEmpty {
            //TODO: show empty state
            return
        }
        
        ReposService
            .search(keyword: searchKeyword,
                    page: currentPage,
                    onSuccess: { [weak self] (repositories) in
                        
                        //TODO: chack page number to append or reset your datasource
                        self?.repositories = repositories
                        self?.presenter?.didLoadRepositories()
                        
            }) { [weak self] (error) in
                self?.presenter?.onError(error)
        }
        
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
