import Foundation

struct ArticleResponse: Codable {
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id: UUID = UUID()
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    var id: String?
    var name: String?
}

extension Article {
    static var dummyData: Article {
        .init(
            source: Source(id: "business-insider", name: "Business Insider"),
            author: "Ayelet Sheffey",
            title: "Trump's new tariffs are poised to hit an already-battered economy - Business Insider",
            description: "Trump said the nation would feel some financial pain due to tariffs. We're already in the thick of it.",
            url: "https://www.businessinsider.com/tariffs-liberation-day-prices-inflation-economy-recession-2025-4",
            urlToImage: "https://i.insider.com/67eae10d69253ccddf9ac9c1?width=1200&format=jpeg",
            publishedAt: ISO8601DateFormatter().date(from: "2025-04-02T07:21:00Z"),
            content: "Companies have warned of rising prices. Markets have plunged..."
        )
    }
}
