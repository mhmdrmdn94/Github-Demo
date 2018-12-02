//
//  RepoDetailsPresenter.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation

class RepoDetailsPresenter: RepoDetailsPresenterProtocol {
    
    var view: RepoDetailsViewProtocol?
    var interactor: RepoDetailsInteractorProtocol
    
    init(view: RepoDetailsViewProtocol, interactor: RepoDetailsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func loadRepositoryDetails() {
        interactor.loadRepositoryDetails()
    }
    
    func loadForks() {
        view?.showForksEmptyState(with: .loading)
        interactor.loadForks()
    }
    
    func getRepositoryViewModel() -> RepositoryViewModel {
        let viewModel = interactor.getRepositoryViewModel()
        return viewModel
    }
    
    func getForksCount() -> Int {
        let count = interactor.getForksCount()
        return count
    }
    
    func getForkViewModel(at indexPath: IndexPath) -> ForkViewModel {
        let viewModel = interactor.getForkViewModel(at: indexPath)
        return viewModel
    }
    
}

extension RepoDetailsPresenter: RepoDetailsInteractorOutputProtocol {
    func didLoadRepositoryDetails() {
        view?.showRepositoryDetails()
    }
    
    func didLoadForks() {
        view?.reloadForksList()
    }
    
    func showEmptyState(with type: GitEmptyStateType) {
        view?.showForksEmptyState(with: type)
    }
}
