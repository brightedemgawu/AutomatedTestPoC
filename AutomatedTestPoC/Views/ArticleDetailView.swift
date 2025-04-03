import SwiftUI
import URLImage

struct ArticleDetailView: View {
    @Environment(\.openURL) private var openURL
    let article: Article

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
                descriptionView
            }
            .padding(.horizontal, 10)
        }
    }

    private var headerView: some View {
        HStack {
            Text(article.source ?? "Unknown Source")
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
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var descriptionView: some View {
        Text(article.welcomeDescription ?? "No description available")
            .font(.body)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var imageView: some View {
        Group {
            if let imageUrl = article.image.flatMap(URL.init) {
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
        Image(systemName: "photo.fill")
            .font(.largeTitle)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color.gray.opacity(0.2))
    }

    private var metadataView: some View {
        HStack {
            Text(article.author ?? "")
            Spacer()
            Text(article.date?.formatted(.dateTime.month(.wide).day()) ?? "")
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
