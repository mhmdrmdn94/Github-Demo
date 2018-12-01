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
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func loadRepositoryDetails() {
        presenter?.didLoadRepositoryDetails()
    }
    
    func loadForks() {
        let f1 = Fork()
        f1.ownerLogin = "Omar Alaa"
        let f2 = Fork()
        f2.ownerLogin = "Mo Ramadan"
        let f3 = Fork()
        f3.ownerLogin = "Hassan Gharib El-Sayed"
        self.forks = [f1, f2, f3]
        presenter?.didLoadForks()
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
