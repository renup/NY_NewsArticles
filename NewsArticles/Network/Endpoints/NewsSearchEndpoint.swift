//
//  NewsSearchEndpoint.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/8/21.
//

import Foundation

enum NewsSearchEndpoint: APIConfiguration {
    
    case searchNews(_ searchText: String)
    
    struct SearchConstants {
        static let svcSearch = "/svc/search/v2/"
        static let search = "articlesearch.json"
    }
    
    var path: String {
        switch self {
        case .searchNews:
            return Constants.baseURLString + SearchConstants.svcSearch + SearchConstants.search
        }
    }
    
    
    var method: String {
        switch self {
        case .searchNews:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .searchNews(let searchText):
            let apiKeyItem = URLQueryItem(name: "api-key", value: Constants.apiKey)
            let searchItem = URLQueryItem(name: "q", value: searchText)
            return [apiKeyItem, searchItem]
        }
    }
    
    
}
