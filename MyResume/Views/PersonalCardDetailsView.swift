//
//  PersonalCardDetailsView.swift
//  MyResume
//
//  Created by Arthur Kleiber on 22/01/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}


struct PersonalCardDetailsView: DismissableView {
    
    @State private var offset = CGFloat.zero
    let personalInformations: PersonalInformations
    
    var dismiss: (() -> Void)?
    
    var body: some View {
        GeometryReader { view in
            ScrollView {
                VStack(alignment: .leading) {
                    PortraitImage(imageLink: personalInformations.photo)
                    Group {
                        Text("\(personalInformations.firstName) \(personalInformations.lastName)")
                            .font(Font.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.init(Colors.titleTextColor))
                            .padding(.top, 20)
                        Text(personalInformations.jobTitle)
                            .foregroundColor(Color(Colors.subtitleTextColor))
                            .font(Font.title3)
                        Text(personalInformations.biography)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                            .font(Font.custom("PlayfairDisplay-Regular", size: 15))
                            .foregroundColor(Color(Colors.textColor))
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
                }
                .background(
                    GeometryReader {
                        Color.clear.preference(
                            key: ViewOffsetKey.self,
                            value: -$0.frame(in: .named("scroll")).origin.y
                        )
                    }
                )
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    if offset < -100 {
                        self.dismiss?()
                    }
                }
            }
            .coordinateSpace(name: "scroll")
        }
        .edgesIgnoringSafeArea(.top)
        .statusBar(hidden: true)
    }
}

//struct PersonalCardDetailsView_Preview: PreviewProvider {
//    static var previews: some View {
//        PersonalCardDetailsView(personalInformations: PersonalInformations())
//    }
//}
