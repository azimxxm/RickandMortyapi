//
//  CachedImageView.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//
import SwiftUI

struct CachedImageView: View {
    let url: String
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear {
                        ImageCacheManager.shared.loadImage(from: url) { loadedImage in
                            self.image = loadedImage
                        }
                    }
            }
        }
    }
}
