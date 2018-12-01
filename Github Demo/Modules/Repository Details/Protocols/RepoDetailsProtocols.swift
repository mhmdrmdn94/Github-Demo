//
//  RepoDetailsProtocols.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

protocol RepoDetailsViewProtocol: class {
    var presenter: RepoDetailsPresenterProtocol? { get set }
    
    func showRepositoryDetails()
    func reloadForksList()
    func showForksEmptyState(with type: GitEmptyStateType)
}

protocol RepoDetailsPresenterProtocol: class {
    var view: RepoDetailsViewProtocol? { get set }
    var interactor: RepoDetailsInteractorProtocol { get set }
    
    func loadForks()
    func loadRepositoryDetails()
    func getRepositoryViewModel() -> RepositoryViewModel
    func getForksCount() -> Int
    func getForkViewModel(at indexPath: IndexPath) -> ForkViewModel
}

protocol RepoDetailsInteractorOutputProtocol: class {
    func didLoadForks()
    func didLoadRepositoryDetails()
    func showEmptyState(with type: GitEmptyStateType)
}

protocol RepoDetailsInteractorProtocol: class {
    var presenter : RepoDetailsInteractorOutputProtocol? { get set}
    
    func loadForks()
    func loadRepositoryDetails()
    func getRepositoryViewModel() -> RepositoryViewModel
    func getForksCount() -> Int
    func getForkViewModel(at indexPath: IndexPath) -> ForkViewModel
}

protocol RepoDetailsBuilderProtocol: class {
    func createRespositoryDetailsModule(using repository: Repository) -> UIViewController
}
