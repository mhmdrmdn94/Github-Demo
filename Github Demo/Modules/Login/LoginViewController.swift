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
    @IBOutlet weak var loginWithGithubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        loginWithGithubView.backgroundColor = .white
        loginWithGithubView.roundCorners(withRadius: 10,
                                         borderWidth: 1,
                                         borderColor: GitColor.primary.value)
        
        //MARK: add login gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginWithGitubViewTapped))
        loginWithGithubView.addGestureRecognizer(gestureRecognizer)
        loginWithGithubView.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func loginWithGitubViewTapped() {
        let webViewController = GitWebViewController()
        present(webViewController, animated: true)
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        let reposListViewController = RespositoriesListBuilder().createRespositoriesListModule()
        UIApplication.shared.keyWindow?.rootViewController = BaseNavigationController(rootViewController: reposListViewController)
    }
    
}
