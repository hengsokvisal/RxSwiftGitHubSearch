//
//  GithubService.swift
//  GithubSearchRepositories
//
//  Created by SuguruSasaki on 2018/04/23.
//  Copyright © 2018年 HengVisal. All rights reserved.
//

import Foundation
import RxSwift

final class GithubService {
    private let apiRepo: GithubAPIRepository = GithubAPIRepository()
    
    private(set) var viewDidLoad: PublishSubject = PublishSubject<GithubModel>()
}

extension GithubService {
    
    func select() -> Void{
        self.apiRepo.select().subscribe( {[unowned self] event in
            switch event {
            case .next(let response):
                debugPrint(response)
                self.viewDidLoad.onNext(response)
            case .error(let error):
                debugPrint(error)
                
            case .completed:
                debugPrint("completed")
            }
        })
    }
}
