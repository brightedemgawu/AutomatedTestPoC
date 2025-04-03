
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
                    .listStyle(.sidebar)
                    .contentMargins(.vertical, 8)
                    .contentMargins(.horizontal, 8)
                    .listSectionSpacing(0) // removes space between section and next header
                    .scrollContentBackground(.hidden)
                    .listRowSpacing(6)
                    .scrollIndicators(.hidden)
                    .edgesIgnoringSafeArea(.horizontal)
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
