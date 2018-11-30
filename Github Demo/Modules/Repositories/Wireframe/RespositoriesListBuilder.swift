//
//  RespositoriesListBuilder.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

class RespositoriesListBuilder: RespositoriesListBuilderProtocol {
    func createRespositoriesListModule() -> UIViewController {
        let viewController = RepositoriesListViewController()
        let interactor: RespositoriesListInteractorProtocol = RespositoriesListInteractor()
        let wireframe: RespositoriesListWireframeProtocol = RespositoriesListWireframe()
        let presenter: RespositoriesListPresenterProtocol & RespositoriesListInteractorOutputProtocol = RespositoriesListPresenter(view: viewController, wireframe: wireframe, interactor: interactor)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
    
    
}
