//
//  webViewViewController.swift
//  RxSwiftiOS
//
//  Created by HengVisal on 3/24/18.
//  Copyright © 2018 Underplot ltd. All rights reserved.
//


import UIKit
import Unbox

import RxSwift
import RxCocoa

class SearchGitHubViewController: UIViewController{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    private let bag = DisposeBag()
    private let repos = Variable<[Repo]>([])
    var test1: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    func bindUI() {
        // observe text, form request, bind table view to result
        print("test1",test1)
       let searchresult = searchBar.rx.text
            .orEmpty
            .filter { query in
                return query.utf8CString.count > 2
            }
            .debounce(0.5, scheduler: MainScheduler.instance)
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
                print("repo1",repo.url)
                self.test1 = repo.url
            }).disposed(by: bag)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            print("IT workkk")
            if segue.identifier == "webView"
            {
                    print("trueeee")
                    let des = segue.destination as? webViewViewController
                    print("test1111",self.test1)
                    des?.test = self.test1
                    print("testing")
            }
        }
    }
    
}
extension SearchGitHubViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
