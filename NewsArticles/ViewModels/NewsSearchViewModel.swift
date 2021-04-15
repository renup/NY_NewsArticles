//
//  NewsSearchViewModel.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/6/21.
//

import Foundation

struct NewsSearchDetails {
    let thumbnailURL: String
    let detailImageURL: String
    let headline: String
    let abstract: String
    let webURL: String
}

final class NewsSearchViewModel {
    
    let router = NewsSearchRouter()
    
    func getNews(for searchTerm: String, _ completion: @escaping (Result<[NewsSearchDetails], APIError>) -> Void){
        var detailsArray = [NewsSearchDetails]()
        
        router.getNews(searchTerm) { result in
            switch result {
            case .success(let news):
                let response = news.response
                var imagesURLArray = [String]()
                for ele in response.docs {
                    let multiArr = ele.multimedia
                    
                    for ele in multiArr {
                        if ele.subtype == "thumbnail" {
                            imagesURLArray.insert(ele.url, at: 0)
                        } else if ele.subtype == "watch268" {
                            imagesURLArray.append(ele.url)
                        }
                    }
                    let thumbURL = (imagesURLArray.first != nil) ? imagesURLArray[0] : ""
                    let detailURL = (imagesURLArray.last != nil) ? imagesURLArray[1] : ""
                    print("thumb = \(thumbURL)")
                    print("detail = \(detailURL)")
                    let details = NewsSearchDetails(thumbnailURL: thumbURL, detailImageURL: detailURL, headline: ele.headline.main, abstract: ele.abstract, webURL: ele.web_url)
                    detailsArray.append(details)
                }
                completion(.success(detailsArray))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
