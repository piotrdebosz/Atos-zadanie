import Foundation

enum NewsAPI: API {
    case getTopHeadlines(country: String?, page: Int?)
    
    private enum Version: String {
        case v2
    }
    
    private var currentVersion: Version {
        .v2
    }
    
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
            return "/\(currentVersion.rawValue)/top-headlines"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getTopHeadlines(let country, let page):
            var params = [                // TODO - move api key somwhere
                URLQueryItem(name: "apiKey", value: "8906011f7dc14fddbbdf5bbc47b93e3a")
            ]
            
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
}
