
import Combine
import Foundation

protocol ArticleViewModel {
    func getArticles()
}

enum ResultState {
    case loading
    case failed(error: Error)
    case success(content: [Article])
}

class ArticleViewModelImpl: ObservableObject, ArticleViewModel {
    private let service: ArticleService

    private(set) var articles = [Article]()
    @Published private(set) var state: ResultState = .loading

    private var cancellables = Set<AnyCancellable>()

    init(service: ArticleService) {
        self.service = service
    }

    func getArticles() {
        state = .loading

        let cancellable = service
            .request(from: .getNews)
            .sink { res in
                switch res {
                case let .failure(error):
                    self.state = .failed(error: error)
                case .finished:
                    self.state = .loading
                }
            } receiveValue: { res in
                self.articles = res.articles
            }
        cancellables.insert(cancellable)
    }
}
