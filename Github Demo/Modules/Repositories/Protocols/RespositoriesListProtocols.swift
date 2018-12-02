//
//  RespositoriesListProtocols.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

protocol RespositoriesListViewProtocol: class {
    var presenter: RespositoriesListPresenterProtocol? { get set }
    
    func reloadRepositories()
    func showEmptyState(with type: GitEmptyStateType)
}

protocol RespositoriesListPresenterProtocol: class {
    var view: RespositoriesListViewProtocol? { get set }
    var wireframe: RespositoriesListWireframeProtocol { get set }
    var interactor: RespositoriesListInteractorProtocol { get set }
    
    func loadRepositories(usingSearchKey keyword: String)
    func loadRepositories()
    func resetSearchArea()
    func getRepositoriesCount() -> Int
    func getViewModel(at indexPath: IndexPath) -> RepositoryViewModel
    func getModel(at indexPath: IndexPath) -> Repository
    func performSelectionActionForRepo(at indexPath: IndexPath)
    func performLogout()
}

protocol RespositoriesListInteractorOutputProtocol: class {
    func didLoadRepositories()
    func showEmptyState(with type: GitEmptyStateType)
}

protocol RespositoriesListInteractorProtocol: class {
    var presenter : RespositoriesListInteractorOutputProtocol? { get set}
    
    func loadRepositories(usingSearchKey keyword: String)
    func loadRepositories()
    func resetSearchArea()
    func getRepositoriesCount() -> Int
    func getViewModel(at indexPath: IndexPath) -> RepositoryViewModel
    func getModel(at indexPath: IndexPath) -> Repository
}

protocol RespositoriesListWireframeProtocol: class {
    func pushRepoDetailsViewController(from view: RespositoriesListViewProtocol,
                                       using repository: Repository)
}

protocol RespositoriesListBuilderProtocol: class {
    func createRespositoriesListModule() -> UIViewController
}
