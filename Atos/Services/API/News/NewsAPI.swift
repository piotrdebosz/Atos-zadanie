import Foundation

enum NewsAPI: API {
    case getTopHeadlines(country: String?, page: Int?)

    var scheme: HTTPScheme {
        switch self {
        case .getTopHeadlines:
            return .https
        }
    }

    var baseURL: String {
        switch self {
        case .getTopHeadlines:
            return "newsapi.org"
        }
    }

    var path: String {
        switch self {
        case .getTopHeadlines:
            return "/v2/top-headlines"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case let .getTopHeadlines(country, page):
            var params = [URLQueryItem(name: "apiKey", value: apiKey)]

            if let country = country {
                params.append(URLQueryItem(name: "country", value: country))
            }

            if let page = page {
                params.append(URLQueryItem(name: "page", value: "\(page)"))
            }

            return params
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTopHeadlines:
            return .get
        }
    }

    private var apiKey: String {
        // Read api key from the Info.plist file
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: Constants.newsApiKey.rawValue) as? String else {
            fatalError("Missing news api key. \(Constants.newsApiKey.rawValue) not found in Info.plist")
        }

        return apiKey
    }

    private enum Constants: String {
        case newsApiKey = "NEWS_API_KEY"
    }
}
