import Combine
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ArticleViewModelImpl = ArticleViewModelImpl(service: ArticleServiceImpl())

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                Group {
                    switch viewModel.state {
                    case .loading:
                        LazyVStack(spacing: 0) {
                            ForEach(0 ..< 11, id: \.self) { _ in
                                ArticleView(
                                    article: .dummyData,
                                    shouldShimmer: true
                                )
                            }
                            .padding(.vertical, 4)
                        }
                        .padding(.horizontal, 8)
                    case let .failed(error):
                        ErrorView(error: error) {
                            self.viewModel.getArticles()
                        }
                    case let .success(content):
                        LazyVStack(spacing: 0) {
                            ForEach(content) { article in
                                NavigationLink {
                                    ArticleDetailView(article: article)
                                } label: {
                                    ArticleView(article: article)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
            .background(Color("pageBackground"))
            .navigationBarTitle("News")
        }
    }
}

#Preview {
    ContentView()
}
