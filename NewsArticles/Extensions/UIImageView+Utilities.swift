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
    
    func loadImage(_ urlString: String) -> URLSessionDataTask? {
       
        if let img = imageCache.object(forKey: urlString as NSString) {
            image = img
            return nil
        }
        return NewsSearchRouter().getImage(urlString) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let dt = data, let img = UIImage(data: dt) else {
                    
                    return
                }
                 DispatchQueue.main.async {
                    imageCache.setObject(img, forKey: urlString as NSString)
                    self.image = img
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    #if DEBUG
                    print("error downloading image = \(error.description), for url = \(urlString)")
                    #endif
                    self.image = UIImage(named: "thumbnail_placeholder")
                }
            }
        }
        
    }
    
}
