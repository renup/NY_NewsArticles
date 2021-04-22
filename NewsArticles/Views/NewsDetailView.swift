//
//  NewsDetailView.swift
//  NewsArticles
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
import UIKit

final class NewsDetailView: UIView {
    
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
    
    func setUp() {
        wrap(view: stack)
        
    }
}
