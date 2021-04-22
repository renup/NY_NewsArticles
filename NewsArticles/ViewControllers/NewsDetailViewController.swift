//
//  NewsDetailViewController.swift
//  NewsArticles
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
import UIKit

final class NewsDetailViewController: UIViewController {
    
    private var newsDetailsView: NewsDetailView?
    
    var details: NewsSearchDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        guard let newsDetails = details else { return }
        newsDetailsView = NewsDetailView(details: newsDetails)
        view = newsDetailsView
    }
    
    
    
}
