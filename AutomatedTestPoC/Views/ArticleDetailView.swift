import SwiftUI
import URLImage

struct ArticleDetailView: View {
    @Environment(\.openURL) private var openURL
    let article: Article

    private var isTruncated: Bool {
        guard let content = article.content else { return false }
        return content.contains("… [+") && content.contains("chars]")
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                headerView
                titleView
                descriptionView
            }
            .padding(.horizontal, 10)
            imageView
            VStack(spacing: 10) {
                metadataView
                contentView
            }
            .padding(.horizontal, 10)
        }
        .background(.pageBackground)
    }

    private var headerView: some View {
        HStack {
            Text(article.source?.name ?? "Unknown Source")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            Spacer()
            Button("Open in source") {
                load(url: article.url)
            }
            .font(.caption2)
            .buttonStyle(.bordered)
        }
    }

    private var titleView: some View {
        Text(article.title ?? "No Title")
            .foregroundColor(Color("textColor"))
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var descriptionView: some View {
        Text(article.description ?? "No description available")
            .font(.body)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.content ?? "No content available")
                .foregroundStyle(.secondary)

            if isTruncated {
                Button("Read More") {
                    load(url: article.url)
                }
                .foregroundStyle(.blue)
            }
        }
        .font(.body)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var imageView: some View {
        Group {
            if let imageUrl = article.urlToImage.flatMap(URL.init) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        placeholderView
                    case let .success(image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    case .failure:
                        placeholderView
                    @unknown default:
                        placeholderView
                    }
                }
            } else {
                placeholderView
            }
        }
    }

    private var placeholderView: some View {
        Image(.no)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .frame(height: 300)
    }

    private var metadataView: some View {
        HStack {
            Text(article.author ?? "")
            Spacer()
            Text(
                article.publishedAt?
                    .formatted(.dateTime.month(.wide).day()) ?? ""
            )
        }
        .font(.caption2)
        .foregroundStyle(.secondary)
    }

    private func load(url: String?) {
        guard let urlString = url, let linkUrl = URL(string: urlString) else { return }
        openURL(linkUrl)
    }
}

#Preview {
    ArticleDetailView(article: .dummyData)
}
