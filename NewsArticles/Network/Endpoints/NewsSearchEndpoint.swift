//
//  NewsSearchEndpoint.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/8/21.
//

import Foundation

enum NewsSearchEndpoint: APIConfiguration {
    
    //https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=raVLlVmt3S3HAu246G4gPeTMOlIFDSjs
    case searchNews(_ searchText: String)
    case fetchImage(_ url: String)
    
    struct SearchConstants {
        static let svcSearch = "svc/search/v2/"
        static let search = "articlesearch.json"
    }
    
    var path: String {
        switch self {
        case .searchNews:
            return Constants.baseApiURLString + SearchConstants.svcSearch + SearchConstants.search
        case .fetchImage(let url):
            return Constants.baseURLString + url
        }
    }
    
    
    var method: String {
        switch self {
        case .searchNews, .fetchImage:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .searchNews(let searchText):
            let apiKeyItem = URLQueryItem(name: "api-key", value: Constants.apiKey)
            let searchItem = URLQueryItem(name: "q", value: searchText)
            return [apiKeyItem, searchItem]
        case .fetchImage:
            return []
        }
    }
    
    
}
