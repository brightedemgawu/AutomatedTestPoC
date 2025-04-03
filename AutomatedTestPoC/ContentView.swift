
import Combine
import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @StateObject var viewModel: ArticleViewModelImpl = ArticleViewModelImpl(service: ArticleServiceImpl())

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case let .failed(error):
                ErrorView(error: error) {
                    self.viewModel.getArticles()
                }
            case let .success(content):
                NavigationStack {
                    List(content) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                load(url: article.url)
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .listRowSpacing(8)
                    .scrollIndicators(.hidden)
                    .background(Color("pageBackground"))
                    .navigationBarTitle("News")
                }
            }
        }
        .onAppear {
            self.viewModel.getArticles()
        }
    }

    func load(url: String?) {
        guard let url = url,
              let linkUrl = URL(string: url) else {
            return
        }
        openURL(linkUrl)
    }
}

#Preview {
    ContentView()
}
