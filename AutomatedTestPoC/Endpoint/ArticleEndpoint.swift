import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum ArticleAPI {
    case getNews
}

extension ArticleAPI: APIBuilder {
    var baseUrl: URL {
        switch self {
        case .getNews:
            return getUrl()
        }
    }

    var path: String {
        switch self {
        case .getNews:
            return "/v2/top-headlines"
        }
    }

    var urlRequest: URLRequest {
        getUrlRequest()
    }

    private func getUrlRequest() -> URLRequest {
        switch self {
        case .getNews:
            var components = URLComponents(
                url: baseUrl.appendingPathComponent(path),
                resolvingAgainstBaseURL: false)
                ?? URLComponents()
            components.queryItems = [
                URLQueryItem(name: "country", value: "us"),
                URLQueryItem(name: "apiKey", value: Configurator.shared.apikey)
            ]
            return URLRequest(url: components.url ?? baseUrl)
        }
    }

    private func getUrl() -> URL {
        let baseUrl = Configurator.shared.baseURL
        guard let url = URL(string: "\(baseUrl)") else {
            fatalError("Failed to create URL with url \(baseUrl)")
        }
        return url
    }
}
