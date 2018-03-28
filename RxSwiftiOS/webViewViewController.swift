//
//  webViewViewController.swift
//  RxSwiftiOS
//
//  Created by HengVisal on 3/24/18.
//  Copyright © 2018 Underplot ltd. All rights reserved.
//

import UIKit
import WebKit
class webViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var lblView: UILabel!
    var test : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.didReceiveMemoryWarning()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            let url = URL(string:self.test!)
            let request = URLRequest(url:url!)
            self.webView.loadRequest(request)
        }
        
    }
    
    
  

}
