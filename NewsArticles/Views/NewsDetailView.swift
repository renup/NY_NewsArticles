//
//  NewsDetailView.swift
//  NewsArticles
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
import UIKit

final class NewsDetailView: UIView {
    
    enum Layout {
        static let insets = UIEdgeInsets(top: 15, left: 10, bottom: -10, right: 10)
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    private lazy var newsAbstractLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, newsAbstractLabel])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    var details: NewsSearchDetails
    
    init(details: NewsSearchDetails) {
        self.details = details
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .white
        wrapToSafeArea(stack, exceptBottom: true, insets: Layout.insets)
        configure()
    }
    
    private func configure() {
        let _ = imageView.loadImage(details.detailImageURL)
        newsAbstractLabel.text = details.abstract
    }
}
