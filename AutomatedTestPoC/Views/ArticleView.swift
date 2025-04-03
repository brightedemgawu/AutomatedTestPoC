import SwiftUI
import UIKit
import URLImage

struct ArticleView: View {
    let article: Article

    var body: some View {
        HStack {
            // TODO: Add image view
            if let image = article.image,
               let url = URL(string: image) {
                URLImage(url, identifier: url.absoluteString) {
                    // This view is displayed before download starts
                    EmptyView()
                } inProgress: { _ in
                    // Display progress
                    ProgressView()
                } failure: { _, _ in
                    // Display error and retry button
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
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
                Image(systemName: "photo.fill")
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "")
                    .foregroundColor(Color("textColor"))
                    .font(.system(size: 18, weight: .semibold))
                Text(article.source ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
            }
        }
        .listRowInsets(EdgeInsets())
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .cardItemElementShadow()
        .raisedRoundedBackground()
    }
}
