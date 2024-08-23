//
//  ImageLoader.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL

    init(url: URL) {
        self.url = url
    }

    func load() {
        if let cachedImage = ImageCache.shared.image(for: url) {
            self.image = cachedImage
        } else {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let uiImage = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    ImageCache.shared.setImage(uiImage, for: self.url)
                    self.image = uiImage
                }
            }
            task.resume()
        }
    }
}
