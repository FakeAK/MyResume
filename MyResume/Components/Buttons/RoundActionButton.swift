//
//  RoundActionButton.swift
//  MyResume
//
//  Created by Arthur Kleiber on 26/01/2021.
//

import Foundation
import SwiftUI


struct RoundActionButton: View {
    
    @Environment(\.openURL) var openURL
    
    var url: URL
    var socialNetwork: SocialNetwork
    
    enum SocialNetwork: String {
        case facebook
        case twitter
        case instagram
        case linkedin
        case github
        case website
    }
    
    var body: some View {
        Button(action: {
            openURL(url)
        }) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(Colors.primaryGradientBlue), Color(Colors.primaryGradientTurquoise)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    SocialNetworkIcon()
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
    
    func SocialNetworkIcon() -> Image {
        switch socialNetwork {
        case .linkedin:
            return Image("linkedin_logo")
        case .github:
            return Image("github_logo")
        default:
            return Image("")
        }
    }
}
