//
//  ReusableView.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/20/21.
//

import Foundation
import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
