//
//  NewsCell.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/20/21.
//

import Foundation
import UIKit

final class NewsCell: UITableViewCell, ReusableView {
    
    enum Layout {
        static let high: Float = 1000
        static let mid: Float = 999
        static let spacing: CGFloat = 8
        static let insets = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        static let separatorInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        static let cellHeight: CGFloat = 60
    }
    
    var urlSessionTask: URLSessionDataTask?

    private(set) lazy var thumbnail: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .center
        view.setContentHuggingPriority(UILayoutPriority.init(rawValue: Layout.high), for: .horizontal)
        return view
    }()
    
    //News Headline
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()
    
    private(set) lazy var stack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [thumbnail, titleLabel])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Layout.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = Layout.separatorInsets
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        wrap(view: stack, insets: Layout.insets)
    }
    
    func configure(_ dataModel: NewsSearchDetails) {
        thumbnail.image = UIImage(named: "thumbnail_placeholder")

        urlSessionTask = thumbnail.loadImage(dataModel.thumbnailURL) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.thumbnail.image = image
            case .failure:
                self.thumbnail.image = UIImage(named: "thumbnail_placeholder")
            }
        }
        titleLabel.text = dataModel.headline
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
        titleLabel.text = nil
        urlSessionTask?.cancel()
        urlSessionTask = nil
    }
    
    func downloadImageIfNeeded(_ urlString: String) {
        
    }
    
}
