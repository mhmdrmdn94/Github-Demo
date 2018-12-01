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
        presenter?.showEmptyState(with: .loading)
        fetchRepositories()
    }
    
    func loadRepositories() {
        fetchRepositories()
    }
    
    func getRepositoriesCount() -> Int {
        let count = repositories.count
        return count
    }
    
    func getViewModel(at indexPath: IndexPath) -> RepositoryViewModel {
        let repository = repositories[indexPath.row]
        let viewModel = repository.getRepositoryViewModel()
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
        presenter?.showEmptyState(with: type)
    }
    
}
