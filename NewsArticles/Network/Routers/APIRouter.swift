//
//  APIRouter.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/6/21.
//

import Foundation

enum APIError: Error {
    case invalidEndpoint
    case missingData
    case serviceUnavailable
    case invalidResponse
    case decodingError
    
    var description: String {
        switch self {
        case .serviceUnavailable:
            return "API failed. Unable to fetch data at this time. Try again in few minutes"
        case .invalidEndpoint:
            return "URL passed was incorrect. Please check if URL and parameters are sent correctly"
        case .invalidResponse:
            return "Invalid response"
        case .missingData:
            return "No data received"
        case .decodingError:
            return "There was a problem in decoding your model"
        }
    }
}

protocol APIRouter {
    func fetch<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIError>) -> Void)
    
    func fetchImage(route: APIConfiguration, completion: @escaping (Result<Data, APIError>) -> Void) -> URLSessionDataTask?
}

extension APIRouter {
    
    private func getURL(route: APIConfiguration) -> URL? {
        let path = route.path
        
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = route.parameters
        return urlComponents?.url
    }
    
    func fetch<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = getURL(route: route) else {
            print("invalid point")
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let _ = URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                
                do {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(value))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.serviceUnavailable))
                }
            }
        }.resume()
    }
    
    func fetchImage(route: APIConfiguration, completion: @escaping (Result<Data, APIError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = getURL(route: route) else { return nil }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let(response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                
                completion(.success(data))// avoid converting to image from data in main thread
            
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.serviceUnavailable))
                }
            }
        }
        dataTask.resume()
        return dataTask
    }


}
