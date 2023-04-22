//
//  ImageLoader.swift
//  Atos
//
//  Created by Piotr Debosz on 22/04/2023.
//

import Foundation

class ImageLoader {
    private let imageCache = NSCache<NSString, NSData>()

    func loadImage(from url: URL) async -> Data? {
        let cacheKey = url.absoluteString as NSString
        
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            return Data(referencing: cachedImage)
        }
        
        do {
            let (data, _) = try await URLSession(configuration: .default).data(from: url)
            
            imageCache.setObject(NSData(data: data), forKey: cacheKey)
            
            return data
        } catch {
            return nil
        }
    }
}
