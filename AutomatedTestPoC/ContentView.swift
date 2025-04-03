import Combine
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ArticleViewModelImpl = ArticleViewModelImpl(service: ArticleServiceImpl())

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .loading:

                    List {
                        ForEach(0 ..< 11, id: \.self) { _ in
                            ArticleView(article: .dummyData)
                                .shimmer(when: true)
                        }
                        .listStyle(.sidebar)
                        .contentMargins(.vertical, 8)
                        .contentMargins(.horizontal, 8)
                        .listSectionSpacing(0) // removes space between section and next header
                        .scrollContentBackground(.hidden)
                        .listRowSpacing(8)
                        .scrollIndicators(.hidden)
                        .edgesIgnoringSafeArea(.horizontal)
                        .background(Color("pageBackground"))
                        .navigationBarTitle("News")
                    }

                case let .failed(error):
                    ErrorView(error: error) {
                        self.viewModel.getArticles()
                    }
                case let .success(content):

                    List(content) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            ArticleView(article: article)
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
            .onAppear {
                self.viewModel.getArticles()
            }
        }
    }
}

#Preview {
    ContentView()
}
