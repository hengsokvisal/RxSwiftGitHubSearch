//
//  Model.swift
//  GithubSearchRepositories
//
//  Created by HengVisal on 3/29/18.
//  Copyright © 2018 HengVisal. All rights reserved.
//

import Foundation

class Repo
{
    let id : Int?
    let name : String?
    let lan : String?
    let url : String?
    
    init?(object:[String: Any]) {
       guard let id = object["id"] as? Int,
            let name = object["name"] as? String,
            let lan = object["language"] as? String,
            let url = object["html_url"] as? String else {return nil}
        
        self.id = id
        self.name = name
        self.lan = lan
        self.url = url
    }
}
