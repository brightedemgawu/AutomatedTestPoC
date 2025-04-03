//
//  ViewExtensions.swift
//  AutomatedTestPoC
//
//  Created by AMALITECH MACBOOK on 03/04/2025.
//

import SwiftUI

struct RaisedRoundedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("NewsCardBackground"), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color("NewsCardBackground")))
            )
    }
}

public extension View {
    func cardItemElementShadow() -> some View {
        shadow(color: .black.opacity(0.02), radius: 0, x: 0, y: 0)
            .shadow(color: .black.opacity(0.10), radius: 4.0, x: 0, y: 3)
    }

    func raisedRoundedBackground() -> some View {
        modifier(RaisedRoundedBackground())
    }

    @ViewBuilder
    func shimmer(when isLoading: Bool) -> some View {
        if isLoading {
            modifier(Shimmer())
                .redacted(reason: isLoading ? .placeholder : [])
        } else {
            self
        }
    }
}

public struct Shimmer: ViewModifier {
    @State private var isInitialState = true

    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                    startPoint: isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1),
                    endPoint: isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3)
                )
            )
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear {
                isInitialState = false
            }
    }
}
