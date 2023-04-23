import Foundation

actor ImageLoader: ImageLoaderType {
    private let imageCache = NSCache<NSString, NSData>()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    // Loads an image from a URL asynchronously.
    // Returns the image data if successful, otherwise returns nil.
    func loadImage(from url: URL) async -> Data? {
        let cacheKey = url.absoluteString as NSString

        // If the image is cached, return the cached data.
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            return Data(referencing: cachedImage)
        }

        // If the image is not cached, load it from the URL.
        do {
            let (data, _) = try await urlSession.data(from: url)

            // Cache the loaded image data.
            imageCache.setObject(NSData(data: data), forKey: cacheKey)

            return data
        } catch {
            return nil
        }
    }
}
