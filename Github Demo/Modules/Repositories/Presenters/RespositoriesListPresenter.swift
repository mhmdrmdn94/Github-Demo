//
//  RespositoriesListPresenter.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation

class RespositoriesListPresenter: RespositoriesListPresenterProtocol {
    weak var view: RespositoriesListViewProtocol?
    var wireframe: RespositoriesListWireframeProtocol
    var interactor: RespositoriesListInteractorProtocol
    
    init(view: RespositoriesListViewProtocol?,
         wireframe: RespositoriesListWireframeProtocol,
         interactor: RespositoriesListInteractorProtocol ) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func loadRepositories(usingSearchKey keyword: String) {
        view?.showLoader()
        interactor.loadRepositories(usingSearchKey: keyword)
    }
    
    func loadRepositories() {
        interactor.loadRepositories()
    }
    
    func getRepositoriesCount() -> Int {
        let count = interactor.getRepositoriesCount()
        return count
    }
    
    func getViewModel(at indexPath: IndexPath) -> RepositoryViewModel {
        let viewModel = interactor.getViewModel(at: indexPath)
        return viewModel
    }
    
    func getModel(at indexPath: IndexPath) -> Repository {
        let model = interactor.getModel(at: indexPath)
        return model
    }
    
    func performSelectionActionForRepo(at indexPath: IndexPath) {
        guard let view = view else { return }
        let repository = interactor.getModel(at: indexPath)
        wireframe.pushRepoDetailsViewController(from: view, using: repository)
    }
    
    func performLogout() {
        interactor.performLogout()
    }
}

extension RespositoriesListPresenter: RespositoriesListInteractorOutputProtocol {
    func showEmptyState(with viewModel: GitEmptyStateViewModel) {
        view?.hideLoader()
        view?.showEmptyState(with: viewModel)
    }
    
    func didLoadRepositories() {
        view?.hideLoader()
        view?.reloadRepositories()
    }
    
    func onError(_ error: Error) {
       view?.hideLoader()
        view?.showErrorMessage(error.localizedDescription)
    }
}
