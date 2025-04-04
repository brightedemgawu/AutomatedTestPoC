import SwiftUI
import UIKit
import URLImage

struct ArticleView: View {
    let article: Article
    var shouldShimmer: Bool = false

    var body: some View {
        HStack(spacing: 10) {
            if let image = article.urlToImage,
               let url = URL(string: image) {
                URLImage(url, identifier: url.absoluteString) {
                    // This view is displayed before download starts
                    EmptyView()
                } inProgress: { _ in
                    // Display progress
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                } failure: { _, _ in
                    // Display error and retry button
                    Image(.no)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } content: { image in
                    // Downloaded image
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .environment(\.urlImageOptions,
                             .init(fetchPolicy: .returnStoreElseLoad(downloadDelay: nil)))

            } else {
                Image(.no)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "")
                    .foregroundColor(Color("textColor"))
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.leading)
                Text(article.source?.name ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .shimmer(when: shouldShimmer)
        .padding(16)
        .raisedRoundedBackground()
        .cardItemElementShadow()
    }
}
