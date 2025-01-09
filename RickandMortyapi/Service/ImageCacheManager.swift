//
//  ImageCacheManager.swift
//  RickandMortyapi
//
//  Created by Azimjon Abdurasulov on 09/01/25.
//


import Foundation
import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cacheDirectory: URL

    private init() {
        let fileManager = FileManager.default
        if let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            cacheDirectory = cacheDir.appendingPathComponent("ImageCache")

            // Create the directory if it doesn't exist
            if !fileManager.fileExists(atPath: cacheDirectory.path) {
                do {
                    try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Failed to create cache directory: \(error)")
                }
            }
        } else {
            fatalError("Unable to access caches directory")
        }
    }

    /// Saves an image to the cache directory
    func saveImageToCache(_ image: UIImage, withName name: String) {
        let filePath = cacheDirectory.appendingPathComponent(name)
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }

        do {
            try data.write(to: filePath)
        } catch {
            print("Failed to save image to cache: \(error)")
        }
    }

    /// Retrieves an image from the cache directory
    func getImageFromCache(withName name: String) -> UIImage? {
        let filePath = cacheDirectory.appendingPathComponent(name)
        if FileManager.default.fileExists(atPath: filePath.path) {
            return UIImage(contentsOfFile: filePath.path)
        }
        return nil
    }

    /// Downloads an image from a URL, saves it to cache, and returns it
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let fileName = (urlString as NSString).lastPathComponent

        // Check if the image exists in the cache
        if let cachedImage = getImageFromCache(withName: fileName) {
            completion(cachedImage)
            return
        }

        // Download the image if not cached
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            // Save the image to cache
            self.saveImageToCache(image, withName: fileName)

            // Return the downloaded image
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}