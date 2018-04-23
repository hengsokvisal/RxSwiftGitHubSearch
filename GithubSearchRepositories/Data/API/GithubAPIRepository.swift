//
//  GithubAPIRepository.swift
//  GithubSearchRepositories
//
//  Created by SuguruSasaki on 2018/04/23.
//  Copyright © 2018年 HengVisal. All rights reserved.
//

import Foundation
import RxSwift

final class GithubAPIRepository {
    private let dataStore: GithubAPIStore = GithubAPIStore()
}

extension GithubAPIRepository {
    
    func select() -> Observable<GithubModel> {
        return self.dataStore.select()
            .map { response in GithubModel() }
    }
}
