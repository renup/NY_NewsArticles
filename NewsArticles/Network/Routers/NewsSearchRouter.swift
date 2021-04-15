//
//  NewsSearchRouter.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/8/21.
//

import Foundation

final class NewsSearchRouter: APIRouter {
    
    func getNews(_ search: String, completion: @escaping (Result<NewsSearchResponse, APIError>) -> Void) {
        
        fetch(route: NewsSearchEndpoint.searchNews(search), completion: completion)
                    
    }
    
}
