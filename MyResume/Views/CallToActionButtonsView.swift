//
//  CallToActionButtonsView.swift
//  MyResume
//
//  Created by Arthur Kleiber on 26/01/2021.
//

import Foundation
import SwiftUI


struct CallToSocialButtonsView: View {
    
    let socialNetworks: [SocialNetwork]
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(socialNetworks) { socialNetwork in
                RoundActionButton(
                    url: URL(string: socialNetwork.link)!,
                    socialNetwork: RoundActionButton.SocialNetwork.init(rawValue: socialNetwork.name) ?? .website
                )
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
    }
}
