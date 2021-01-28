//
//  RoundActionButton.swift
//  MyResume
//
//  Created by Arthur Kleiber on 26/01/2021.
//

import Foundation
import SwiftUI


struct RoundActionButton: View {
    
    var action: (() -> ())
    var icon: Image
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(Colors.primaryGradientBlue), Color(Colors.primaryGradientTurquoise)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                )
            }
        }
        .frame(width: 75, height: 75, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 75 / 2)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(Colors.primaryGradientBlue), Color(Colors.primaryGradientTurquoise)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 1
                )
        )
    }
}
