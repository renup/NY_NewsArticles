//
//  NewsSearchResponse.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/8/21.
//

import Foundation

struct NewsSearchResponse: Decodable {
    let response: Response
}

struct Response: Decodable {
    let docs: [NewsDetails]
}

struct NewsDetails: Decodable {
    let multimedia: [MultiMedia]
    let headline: HeadLine
    let web_url: String
    let abstract: String
}

struct MultiMedia: Decodable {
    let subtype: String
    let url: String
}

struct HeadLine: Decodable {
    let main: String
}
