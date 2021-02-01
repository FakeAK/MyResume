//
//  LinkButton.swift
//  MyResume
//
//  Created by Arthur Kleiber on 01/02/2021.
//

import Foundation
import SwiftUI

struct LinkButton: View {
    
    @Environment(\.openURL) private var openURL
    
    let link: String
    
    var body: some View {
        Button(action: {
            if let url = URL(string: link) {
                openURL(url)
            }
        }) {
            Text(link)
                .font(Font.custom("PlayfairDisplay-Regular", size: 15))
                .underline()
                .gradientForeground(
                    colors: [
                        Color(Colors.primaryGradientBlue),
                        Color(Colors.primaryGradientTurquoise)
                    ]
                )
        }
    }
}
