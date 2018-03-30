//
//  ViewController.swift
//  GithubSearchRepositories
//
//  Created by HengVisal on 3/29/18.
//  Copyright © 2018 HengVisal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Unbox

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let repos = Variable<[Repo]>([])
    private var val: String?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        githubSearch()
    }
    func githubSearch()
    {
        let searchresult = searchBox.rx.text
            .orEmpty
            .filter { query in
                return query.utf8CString.count > 2
            }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        .map { query in
            var apiUrl = URLComponents(string: "https://api.github.com/search/repositories")!
            apiUrl.queryItems = [URLQueryItem(name: "q", value: query)]
            return URLRequest(url: apiUrl.url!)
        }
        
        .flatMapLatest { request in
            return URLSession.shared.rx.json(request: request)
                .catchErrorJustReturn([])
        }

        .map { json -> [Repo] in
            guard let json = json as? [String: Any],
                let items = json["items"] as? [[String: Any]]  else {
                    return []
            }
            return items.flatMap(Repo.init)
        }
        
        searchresult
            .bind(to: tableView.rx.items) { tableView, row, repo in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel!.text = repo.name
            cell.detailTextLabel?.text = repo.url
            return cell
          }.disposed(by: bag)

        tableView.rx.modelSelected(Repo.self)
         .subscribe(onNext: {[unowned self] repo in
                self.performSegue(withIdentifier: "webView", sender: self)
                self.val = repo.url
          }).disposed(by: bag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            if segue.identifier == "webView"
            {
                let des = segue.destination as? webViewViewController
                des?.val = self.val
            }
        }
    }
    
}

