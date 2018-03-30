//
//  webViewViewController.swift
//  GithubSearchRepositories
//
//  Created by HengVisal on 3/29/18.
//  Copyright © 2018 HengVisal. All rights reserved.
//

import UIKit
import WebKit

class webViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var val : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            let url = URL(string:self.val!)
            let request = URLRequest(url:url!)
            self.webView.loadRequest(request)
        }
    }
}
