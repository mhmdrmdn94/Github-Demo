//
//  RespositoriesListInteractor.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire

class RespositoriesListInteractor: RespositoriesListInteractorProtocol {
    
    var presenter: RespositoriesListInteractorOutputProtocol?
    
    fileprivate var repositories = [Repository]()
    fileprivate var currentPage = 1
    fileprivate var searchKeyword = ""
    fileprivate var hasMorePages = true
    
    func loadRepositories(usingSearchKey newKeyword: String) {
        if searchKeyword != newKeyword {
            searchKeyword = newKeyword
            repositories = []
            currentPage = 1
            hasMorePages = true
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
    
    func resetSearchArea() {
        repositories = []
        currentPage = 1
        hasMorePages = true
        presenter?.showEmptyState(with: .loading)
        fetchRepositories()
    }
    
    func getHasMorePages() -> Bool {
        return hasMorePages
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
}

fileprivate extension RespositoriesListInteractor {
    
    func showEmptyState(withType type: GitEmptyStateType) {
        presenter?.showEmptyState(with: type)
    }
    
    func fetchRepositories() {
        let searchArea = GitSearchArea.current
        switch searchArea {
        case .myRepositories:
            let userLogin = UserSessionManager.currentUser?.login ?? ""
            searchInCurrentLoggedInUserRepositories(username: userLogin)
        case .allRepositories:
            searchInAllGithubRepositories()
        }
    }
    
    func searchInAllGithubRepositories() {
        ReposService.search(
            keyword: searchKeyword,
            page: currentPage,
            onSuccess: { [weak self] (repositories) in

                self?.handleRepositoriesResponse(repos: repositories)
                
        }) { [weak self] (error) in
            let nserror = error as NSError
            if nserror.code == 1009 {
                self?.showEmptyState(withType: .noInternetConnection)
            } else {
                self?.showEmptyState(withType: .someThingWentWrong)
            }
        }
    }
    
    
    func searchInCurrentLoggedInUserRepositories(username: String) {
        ReposService.searchInLoggedInUserRepositories(
            keyword: searchKeyword,
            page: currentPage,
            username: username,
            onSuccess: { [weak self] (repositories) in
                
                self?.handleRepositoriesResponse(repos: repositories)

                
        }) { [weak self] (error) in
            let nserror = error as NSError
            if nserror.code == 1009 {
                self?.showEmptyState(withType: .noInternetConnection)
            } else {
                self?.showEmptyState(withType: .someThingWentWrong)
            }
        }
    }
    
    func handleRepositoriesResponse(repos: [Repository]) {
        if repos.isEmpty {
            if currentPage == 1 {
                showEmptyState(withType: .noResults)
                repositories = []
                return
            } else {
                //that was tha last page to have results, then do nothing
                hasMorePages = false
                presenter?.didLoadRepositories()
                return
            }
        }
        
        if currentPage == 1 {
            repositories = repos
        } else {
            repositories.append(contentsOf: repos)
        }
        currentPage = currentPage + 1
        presenter?.didLoadRepositories()
    }
    
}
