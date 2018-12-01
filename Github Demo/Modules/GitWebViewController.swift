//
//  GitWebViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

class GitWebViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.delegate = self
        let urlString = "https://github.com/login/oauth/authorize?client_id=156d628c55ad8af56059&scope=repo"
        if let url = URL(string: urlString) {
            let req = URLRequest(url: url)
            webView.loadRequest(req)
        }
        
    }

}

extension GitWebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url, url.host == "www.google.com" {
            if let code = url.query?.components(separatedBy: "code=").last {
                let urlString = "https://github.com/login/oauth/access_token"
                if let tokenUrl = URL(string: urlString) {
                    var req = URLRequest(url: tokenUrl)
                    req.httpMethod = "POST"
                    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    req.addValue("application/json", forHTTPHeaderField: "Accept")
                    let params = [
                        "client_id" : "156d628c55ad8af56059",
                        "client_secret" : "58248becb8c7f2e8a99e87489846b979bf64e439",
                        "code" : code,
                        "scope": "repo"
                        ]
                    do {
                        req.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
                            if let data = data {
                                do {
                                    let decodedJson = try JSONSerialization.jsonObject(with: data, options: [])
                                    if let content = decodedJson as? [String: AnyObject] {
                                        if let accessToken = content["access_token"] as? String {
                                            self.getUser(accessToken: accessToken)
                                        }
                                    }
                                } catch(let error) {
                                    print(error.localizedDescription)
                                }
                            }
                            
                        }
                        
                        
                        task.resume()
                        
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                }
            }
            return false
        }
        return true
        
    }
    
    func getUser(accessToken: String) {
        let urlString = "https://api.github.com/user"
        if let url = URL(string: urlString) {
            var req = URLRequest(url: url)
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
            
            
            let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
                if let data = data {
                    do {
                        let decodedJson = try JSONSerialization.jsonObject(with: data, options: [])
                        if let content = decodedJson as? [String: AnyObject] {
                            print(content)
                        }
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
