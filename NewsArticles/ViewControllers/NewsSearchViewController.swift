//
//  NewsSearchViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 3/22/21.
//

import UIKit

class NewsSearchViewController: UIViewController {

    let vm = NewsSearchViewModel()
    
    lazy var tableView: NewsSearchView = {
        let tableView = NewsSearchView()
        tableView.didSelectNewsItem = { [weak self] item in
            self?.didSelectNews(item)
        }
        
        tableView.searching = {[weak self] searchText in
            self?.searchNews(searchText)
        }
        
        tableView.refreshList = {[weak self] in
//            self?.refreshList()
            self?.searchNews("")
        }
        return tableView
    }()
    
    var didSelectNews: (NewsSearchDetails) -> Void = { _ in }
//    var filterContent: (String) -> Void = { _ in }
    var refreshList: () -> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        view.backgroundColor = .white
        searchNews("election")
        title = "Latest News"
        navigationItem.searchController = tableView.searchController
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.searchController.dismiss(animated: false, completion: nil)
    }
    
    func searchNews(_ text: String) {
        vm.getNews(for: text) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.tableView.newsList = details
//                print(self.newsDetails.count)
            case .failure(let error):
                print(error.description)
            }
        }
    }


}

