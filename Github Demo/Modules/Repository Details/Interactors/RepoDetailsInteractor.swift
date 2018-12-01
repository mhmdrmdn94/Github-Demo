//
//  RepoDetailsInteractor.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation

class RepoDetailsInteractor: RepoDetailsInteractorProtocol {
    var presenter: RepoDetailsInteractorOutputProtocol?
    
    fileprivate var repository: Repository
    fileprivate var forks = [Fork]()
    fileprivate var currentPage = 1
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func loadRepositoryDetails() {
        presenter?.didLoadRepositoryDetails()
    }
    
    func loadForks() {
        guard let ownerName = repository.ownerLogin,
            let repoName = repository.name, !ownerName.isEmpty, !repoName.isEmpty else {
                presenter?.showEmptyState(with: .someThingWentWrong)
                return
        }
        
        if let forksCount = repository.numberOfForks, forksCount == 0 {
            presenter?.showEmptyState(with: .noResults)
            return
        }
        
        ForksService.getForks(forRepo: repoName,
                              forOwner: ownerName,
                              page: currentPage,
                              onSuccess: { [weak self] (newForks) in
                                guard let strongSelf = self else {
                                    self?.presenter?.showEmptyState(with: .someThingWentWrong)
                                    return
                                }
                                
                                strongSelf.forks.append(contentsOf: newForks)
                                strongSelf.currentPage = strongSelf.currentPage + 1
                                strongSelf.presenter?.didLoadForks()
        }) { [weak self] (error) in
            let nserror = error as NSError
            if nserror.code == 1009 {
                self?.presenter?.showEmptyState(with: .noInternetConnection)
            } else {
                self?.presenter?.showEmptyState(with: .someThingWentWrong)
            }
        }
        
        
    }
    
    func getRepositoryViewModel() -> RepositoryViewModel {
        let viewModel = repository.getRepositoryViewModel()
        return viewModel
    }
    
    func getForksCount() -> Int {
        let count = forks.count
        return count
    }
    
    func getForkViewModel(at indexPath: IndexPath) -> ForkViewModel {
        let viewModel = forks[indexPath.row].getForkViewModel()
        return viewModel
    }
}
