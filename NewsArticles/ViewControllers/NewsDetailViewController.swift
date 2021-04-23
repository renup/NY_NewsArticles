//
//  NewsDetailViewController.swift
//  NewsArticles
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
import UIKit
import MessageUI

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
        
        let leftBarButton = UIBarButtonItem(
            title: "Share",
            style: .plain,
            target: self,
            action: #selector(shareNews(_:))
        )
        navigationItem.setRightBarButton(leftBarButton, animated: true)
    }
    
    @objc func shareNews(_ sender: UIBarButtonItem) {
        guard let newsDetail = details else { return }
        
        let activity = UIActivityViewController(
            activityItems: ["Check out this news:  ", newsDetail.webURL],
            applicationActivities: nil
          )
          activity.popoverPresentationController?.barButtonItem = sender
          present(activity, animated: true, completion: nil)
    }
    
}
