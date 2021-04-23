//
//  NewsSearchViewModel.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/6/21.
//

import Foundation
import UIKit

struct NewsSearchDetails {
    let thumbnailURL: String
    let detailImageURL: String
    let headline: String
    let abstract: String
    let webURL: String
}

class NewsSearchViewModel {
    
    let router: NewsSearchRouter
    
    init(router: NewsSearchRouter = NewsSearchRouter()) {
        self.router = router
    }
    
    func getNews(for searchTerm: String, _ completion: @escaping (Result<[NewsSearchDetails], APIError>) -> Void){
        var detailsArray = [NewsSearchDetails]()
        
        router.getNews(searchTerm) { result in
            switch result {
            case .success(let news):
                let response = news.response
                var imagesDictionary = [String : String]()
                for ele in response.docs {
                    let multiArr = ele.multimedia
                    
                    for ele in multiArr {
                        if ele.subtype == "thumbnail" {
                            imagesDictionary["thumb"] = ele.url
                            print("thumb = \(ele.url)")
                        } else if ele.subtype == "watch268" {
                            imagesDictionary["watch"] = ele.url
                            print("watch = \(ele.url)")
                        }
                    }
                
                    let details = NewsSearchDetails(
                        thumbnailURL: imagesDictionary["thumb"] ?? "",
                        detailImageURL: imagesDictionary["watch"] ?? "",
                        headline: ele.headline.main, abstract: ele.abstract,
                        webURL: ele.web_url
                    )
                    detailsArray.append(details)
                }
                completion(.success(detailsArray))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
