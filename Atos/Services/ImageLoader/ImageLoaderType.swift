import Foundation

protocol ImageLoaderType {
    func loadImage(from url: URL) async -> Data?
}
