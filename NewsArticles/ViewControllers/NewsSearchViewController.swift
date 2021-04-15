//
//  NewsSearchViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 3/22/21.
//

import UIKit

class NewsSearchViewController: UIViewController {

    let vm = NewsSearchViewModel()
    
    var newsDetails: [NewsSearchDetails] = [] {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchNews("election")
    }
    
    func searchNews(_ text: String) {
        vm.getNews(for: text) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.newsDetails = details
                print(self.newsDetails.count)
            case .failure(let error):
                print(error.description)
            }
        }
    }


}

