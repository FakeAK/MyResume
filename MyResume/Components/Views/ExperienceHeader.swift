//
//  ExperienceHeader.swift
//  MyResume
//
//  Created by Arthur Kleiber on 01/02/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ExperienceHeader: View {
    
    @State private var animationAmount: CGFloat = 0
    
    let experience: Experience
    
    var body: some View {
        VStack(alignment: .center) {
            if let logoLink = experience.company.logo, let url = URL(string: logoLink) {
                HStack {
                    Spacer()
                    LinearGradient(
                        gradient: Gradient(colors: [Color(Colors.primaryGradientBlue), Color(Colors.primaryGradientTurquoise)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .mask(
                        WebImage(url: url)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(animationAmount)
                            .opacity(Double(animationAmount))
                            .animation(.linear(duration: 0.5))
                    )
                    .frame(width: 100, height: 100, alignment: .center)
                    Spacer()
                }.padding(.top, 50)
            }
            
            Text(experience.company.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(Colors.titleTextColor))
            Text(experience.jobTitle)
                .font(Font.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(Color(Colors.titleTextColor))
            Text("\(Date.getShortDateAsString(from: experience.from)) - \(Date.getShortDateAsString(from: experience.to))")
                .font(Font.system(size: 15))
                .padding(.top, 20)
                .foregroundColor(Color(Colors.subtitleTextColor))
        }.onAppear {
            self.animationAmount = 1
        }
    }
}
