//
//  NewsSearchViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 3/22/21.
//

import UIKit

class NewsSearchViewController: UIViewController {

    let viewModel = NewsSearchViewModel()
    
    lazy var tableView: NewsSearchView = {
        let tableView = NewsSearchView()
        tableView.didSelectNewsItem = { [weak self] item in
            self?.didSelectNews(item)
        }
        
        tableView.searching = {[weak self] searchText in
            self?.searchNews(searchText)
        }
        
        tableView.refreshList = {[weak self] in
            self?.searchNews("")
        }
        return tableView
    }()
    
    var didSelectNews: (NewsSearchDetails) -> Void = { _ in }
    var refreshList: () -> Void = {}
    var activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        view.backgroundColor = .white
        searchNews("election")
        title = "News"
        navigationItem.searchController = tableView.searchController
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.searchController.dismiss(animated: false, completion: nil)
    }
    
    func searchNews(_ text: String) {
        showActivityIndicator()
        /// Fetching news based on search text
        viewModel.getNews(for: text) {[weak self] (result) in
            guard let self = self else { return }
            defer { self.hideActivityIndicator() }
            switch result {
            case .success(let details):
                self.tableView.newsList = details
            case .failure(let error):
                print(error.description)
            }
        }
    }

    //MARK: Activity Indicator methods
      
    func showActivityIndicator() {
        activityView.center = tableView.center
        tableView.addSubview(activityView)
        activityView.startAnimating()
    }

    func hideActivityIndicator(){
       activityView.stopAnimating()
       activityView.hidesWhenStopped = true
    }

}

