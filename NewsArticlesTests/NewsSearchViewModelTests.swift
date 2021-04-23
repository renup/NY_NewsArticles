//
//  NewsSearchViewModelTests.swift
//  NewsArticlesTests
//
//  Created by Anil Punjabi on 4/22/21.
//

import XCTest
@testable import NewsArticles

class NewsSearchViewModelTests: XCTestCase {
    
    var viewModel: NewsSearchViewModel!
    var router: NewsRouterSpy!

    override func setUpWithError() throws {
        router = NewsRouterSpy()
        viewModel = NewsSearchViewModel(router: router)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
    }
    
    func test_getNews_should_return_newsSearchDetails() {
        
        var detailsArray: [NewsSearchDetails] = []
        viewModel.getNews(for: "election") { (result) in
            switch result {
            case .success(let details):
                detailsArray = details
            case .failure(let err):
                assertionFailure(err.description)
            }
        }
        
        let detail = detailsArray[0]
        XCTAssertEqual("A Treasury Department document shed more light on links between the campaign and Russian spies.", detail.abstract)
        
    }

}

final class NewsRouterSpy: NewsSearchRouter {
    
    override func getNews(_ search: String, completion: @escaping (Result<NewsSearchResponse, APIError>) -> Void) {
        guard let response = JsonKit().newsItems() else {
            assertionFailure("could not get news response")
            return
        }
        completion(.success(response))
    }

}
