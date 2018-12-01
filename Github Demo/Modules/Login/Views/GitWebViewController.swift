//
//  GitWebViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

protocol GitWebViewControllerDelegate: class {
    func didLoginSuccessfully()
    func onError()
}

class GitWebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    weak var delegate: GitWebViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestVerificationCode()
    }
    
    func requestVerificationCode() {
        webView.delegate = self
        let urlString = APIConstants.githubAuthorizationUrl.rawValue
        if let url = URL(string: urlString) {
            let req = URLRequest(url: url)
            webView.loadRequest(req)
        }
    }
}

extension GitWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        Activity.showLoader()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        Activity.hideLoader()
    }
    
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.url, url.host == APIConstants.githubCallbackUrl.rawValue {
            if let code = url.query?.components(separatedBy: "code=").last {
                
                GithubAuthInteractor
                    .shared
                    .loadUserAccessTocken(
                        usingCode: code,
                        onSuccess: { [weak self] (token) in
                            if token == nil {
                                return
                            } else {
                                GithubAuthInteractor.shared
                                    .loadUserProfile(onSuccess: { [weak self] (user) in
                                        if user == nil {
                                            return
                                        } else {
                                            //TODO: Authenticated :)
                                            self?.delegate?.didLoginSuccessfully()
                                        }
                                    }, onFailure: { [weak self] (error) in
                                        print(error.localizedDescription)
                                        self?.delegate?.onError()
                                    })
                            }
                    }) { (error) in
                        print(error.localizedDescription)
                }
                return true
            }
            return false
        }
        return true
    }
}
