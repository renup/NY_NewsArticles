//
//  UIImage+Utilities.swift
//  NewsArticles
//
//  Created by Anil Punjabi on 4/21/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(_ urlString: String, completion: @escaping (Result<UIImage?, APIError>) -> Void) -> URLSessionDataTask? {
       
        if let img = imageCache.object(forKey: urlString as NSString) {
            completion(.success(img))
        }
        return NewsSearchRouter().getImage(urlString) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data, let img = UIImage(data: dt) else {
                    DispatchQueue.main.async {
                        completion(.failure(.missingData))
                    }
                    return
                }
                 DispatchQueue.main.async {
                    imageCache.setObject(img, forKey: urlString as NSString)
                    
                    completion(.success(img))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
    }
    
}
