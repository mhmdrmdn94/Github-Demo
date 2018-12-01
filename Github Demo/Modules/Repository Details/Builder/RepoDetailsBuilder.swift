//
//  RepoDetailsBuilder.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

class RepoDetailsBuilder: RepoDetailsBuilderProtocol {
    func createRespositoryDetailsModule(using repository: Repository) -> UIViewController {
        let viewController = RepoDetailsViewController()
        let interactor: RepoDetailsInteractorProtocol = RepoDetailsInteractor(repository: repository)
        let presenter: RepoDetailsPresenterProtocol & RepoDetailsInteractorOutputProtocol = RepoDetailsPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
