//
//  CachedAsyncImage.swift
//  OpenWeather
//
//  Created by karthikdamera on 23/08/24.
//

import SwiftUI

import SwiftUI

struct CachedAsyncImage: View {
    @ObservedObject var loader: ImageLoader

    init(url: URL) {
        loader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .onAppear {
                    loader.load()
                }
        }
    }
}
