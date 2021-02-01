//
//  View.swift
//  MyResume
//
//  Created by Arthur Kleiber on 31/01/2021.
//

import SwiftUI

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                gradient: .init(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
        .mask(self)
    }
}
