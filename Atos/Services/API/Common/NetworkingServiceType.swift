import Foundation

protocol NetworkingServiceType {
    func request<T: Decodable>(endpoint: API) async -> Result<T, Error>
}
