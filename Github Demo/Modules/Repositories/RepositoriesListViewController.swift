//
//  RepositoriesListViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

class RepositoriesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openDetailsTapped(_ sender: UIButton) {
        
        let detailsViewController = RepoDetailsViewController()
        navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
    

}
