//
//  LoginViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak fileprivate var skipButton: UIButton!
    @IBOutlet weak fileprivate var emailTextField: UITextField!
    @IBOutlet weak fileprivate var loginButton: UIButton!
    @IBOutlet weak fileprivate var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        loginButton.roundCorners(withRadius: 10)
        loginButton.backgroundColor = GitColor.darkBlue.value
        loginButton.tintColor = .white
    }
    @IBAction func skipButtonTapped(_ sender: UIButton) {
       openRepositoriesListViewController()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        openRepositoriesListViewController()
    }
    
    private func openRepositoriesListViewController() {
        let reposListViewController = RespositoriesListBuilder().createRespositoriesListModule()
        UIApplication.shared.keyWindow?.rootViewController = BaseNavigationController(rootViewController: reposListViewController)
    }
    
}
