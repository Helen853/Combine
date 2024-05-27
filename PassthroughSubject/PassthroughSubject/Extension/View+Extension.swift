//
//  View+Extension.swift
//  PassthroughSubject
//
//  Created by Киса Мурлыса on 24.05.2024.
//

import SwiftUI

struct IsVisibleModifier: ViewModifier{
    var isVisible: Bool
    var transition: AnyTransition

    func body(content: Content) -> some View {
        ZStack{
            if isVisible{
                content
                    .transition(transition)
            }
        }
    }
}

extension View {
    func isVisible(
        isVisible: Bool,
        transition: AnyTransition = .scale
    ) -> some View{
        modifier(
            IsVisibleModifier(
                isVisible: isVisible,
                transition: transition
            )
        )
    }
}

