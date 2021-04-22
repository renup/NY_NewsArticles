//
//  NewsDetailViewController.swift
//  NewsArticles
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
import UIKit

final class NewsDetailViewController: UIViewController {
    
    private lazy var newsDetailsView: NewsDetailView = {
        let detailsView = NewsDetailView()
        return detailsView
    }()
    
    var details: NewsSearchDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
