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
    func pushRepoDetailsViewController(from view: RespositoriesListViewProtocol) {
        guard let sourceView = view as? UIViewController else { return }
        sourceView.navigationController?
            .pushViewController(RepoDetailsViewController(), animated: true)
    }
    
    
}
