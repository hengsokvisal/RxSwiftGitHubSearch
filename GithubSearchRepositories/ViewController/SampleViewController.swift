//
//  SampleViewController.swift
//  GithubSearchRepositories
//
//  Created by SuguruSasaki on 2018/04/23.
//  Copyright © 2018年 HengVisal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SampleViewController: UIViewController {
    
    private let service: GithubService = GithubService()
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.service.viewDidLoad
            .map { $0 }
            .bind(to: self.onLoadComplete )
            .disposed(by: self.disposeBag)
        
       self.service.select()
    }

   
    var onLoadComplete: Binder<GithubModel> {
        return Binder(self) { (vc, model) in
            // do something
        }
    }

}
