//
//  RespositoriesListWireframe.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

class RespositoriesListWireframe: RespositoriesListWireframeProtocol {
    func pushRepoDetailsViewController(from view: RespositoriesListViewProtocol,
                                       using repository: Repository) {
        guard let sourceView = view as? UIViewController else { return }
        let detailsViewController = RepoDetailsBuilder().createRespositoryDetailsModule(using: repository)
        sourceView.navigationController?
            .pushViewController(detailsViewController, animated: true)
    }
    
    
}
