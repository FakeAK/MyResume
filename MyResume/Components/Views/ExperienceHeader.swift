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
            HStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(colors: [Color(Colors.primaryGradientBlue), Color(Colors.primaryGradientTurquoise)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    WebImage(url: URL(string: experience.company.logo))
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
            Text(experience.company.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(Colors.titleTextColor))
            Text(experience.jobTitle)
                .font(Font.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(Color(Colors.titleTextColor))
            Text("April 2020 - Juin 2021")
                .font(Font.system(size: 15))
                .padding(.top, 20)
                .foregroundColor(Color(Colors.subtitleTextColor))
        }.onAppear {
            self.animationAmount = 1
        }
    }
}
