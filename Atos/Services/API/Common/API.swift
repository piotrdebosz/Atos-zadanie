import Foundation

// API protocol represents single external service API
// that we connect to get data
//
protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}
