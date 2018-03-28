//
//  webViewViewController.swift
//  RxSwiftiOS
//
//  Created by HengVisal on 3/24/18.
//  Copyright © 2018 Underplot ltd. All rights reserved.
//


import Foundation

class Repo {
    let id: Int
    let name: String
    let language: String
    let url : String

    init?(object: [String: Any]) {
        guard let id = object["id"] as? Int,
            let name = object["name"] as? String,
            let language = object["language"] as? String ,
            let url = object["html_url"] as? String else {
                return nil
        }
        self.id = id
        self.name = name
        self.language = language
        self.url = url
    }

}
class getValue {
    let hm = 2}
