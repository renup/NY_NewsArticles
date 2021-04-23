//
//  XCTestCase+.swift
//  NewsArticlesTests
//
//  Created by Anil Punjabi on 4/22/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func waitForNextRunLoop() {
        let expectation = self.expectation(description: "Wait for next run loop")
        OperationQueue.main.addOperation {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
