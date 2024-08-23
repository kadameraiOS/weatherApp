//
//  ImageCache.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()

    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

