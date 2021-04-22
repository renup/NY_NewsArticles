//
//  NewsCoordinator.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/6/21.
//

import Foundation
import UIKit

final class NewsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var detailViewController: NewsDetailViewController?
    
    private var newsSearchViewController: NewsSearchViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showNewsSearchView()
    }
    
    private func showNewsSearchView() {
        let searchViewController = NewsSearchViewController()
        searchViewController.didSelectNews = {[weak self] item in
            self?.showNewsDetailsView(item)
        }
        newsSearchViewController = searchViewController
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    private func showNewsDetailsView(_ details: NewsSearchDetails) {
        let detailViewController = NewsDetailViewController()
        detailViewController.details = details
        self.detailViewController = detailViewController
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func stop() {
        
    }
    
    
}
