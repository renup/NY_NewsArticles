//
//  JsonKit.swift
//  NewsArticlesTests
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
@testable import NewsArticles

final class JsonKit {
    
    typealias NewsSearchResult = NewsSearchResponse
    
    func loadJson<T: Decodable>(_ fileName: String = "newsSearch") -> T? {
       if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
           do {
               let data = try Data(contentsOf: url)
               let decoder = JSONDecoder()
               let jsonData = try decoder.decode(T.self, from: data)
               return jsonData
           } catch {
               print("error:\(error)")}
           }
       return nil
    }
    
    func newsItems(_ fileName: String = "newsSearch") -> NewsSearchResponse? {
        guard let response: NewsSearchResponse = loadJson(fileName) else { return nil }
        return response
    }
    
}

