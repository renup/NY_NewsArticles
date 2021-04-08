//
//  APIConfiguration.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/6/21.
//

import Foundation

protocol APIConfiguration {
    var path: String { get }
    var method: String { get }
    var parameters: [URLQueryItem] { get }
}
