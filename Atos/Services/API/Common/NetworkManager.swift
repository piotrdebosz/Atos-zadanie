import Foundation

// TODO: add protocol
protocol NetworkManagerType {
    func request<T: Decodable>(endpoint: API) async -> Result<T, Error>
}

final class NetworkManager: NetworkManagerType {
    enum Error: Swift.Error {
        case cannotConstructURL
        case invalidStatusCode
        case invalidResponse
        case cannotParseResponse
    }

    /// Builds the relevent URL components from the values specified in the API
    private func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        return components
    }

    func request<T>(endpoint: API) async -> Result<T, Swift.Error> where T: Decodable {
        let components = buildURL(endpoint: endpoint)

        guard let url = components.url else {
            return .failure(Error.cannotConstructURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await URLSession(configuration: .default).data(for: urlRequest)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200 ..< 300 ~= statusCode else {
                return .failure(Error.invalidStatusCode)
            }

            let responseObject = try JSONDecoder().decode(T.self, from: data)
            //                return .failure(.cannotParseResponse)
            //            }

            return .success(responseObject)
            // TODO, remove debug
        } catch let DecodingError.keyNotFound(key, context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(type, context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch let DecodingError.dataCorrupted(context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        } catch {
            return .failure(Error.invalidResponse)
        }

        return .failure(Error.cannotConstructURL)
    }
}
