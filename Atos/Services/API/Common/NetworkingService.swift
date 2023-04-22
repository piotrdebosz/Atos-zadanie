import Foundation

final class NetworkingService: NetworkingServiceType {
    enum Error: Swift.Error {
        case cannotConstructURL
        case invalidStatusCode
        case invalidResponse
        case cannotParseResponse
    }

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    // Builds the relevant URL components from the values specified in the API.
    private func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        return components
    }

    // Performs an API request and returns the result as a Decodable object or an error.
    func request<T>(endpoint: API) async -> Result<T, Swift.Error> where T: Decodable {
        let components = buildURL(endpoint: endpoint)

        guard let url = components.url else {
            return .failure(Error.cannotConstructURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200 ..< 300 ~= statusCode else {
                return .failure(Error.invalidStatusCode)
            }

            let responseObject = try JSONDecoder().decode(T.self, from: data)

            return .success(responseObject)
        } catch {
            return .failure(Error.invalidResponse)
        }
    }
}
