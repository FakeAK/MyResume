//
//  PortraitImage.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PortraitImage: View {
    var fullName: String
    var jobTitle: String
    var imageLink: String
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: imageLink))
                .resizable()
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .overlay(Color(Colors.blueOverlay).opacity(0.4))
                .overlay(
                    FullNameJobOverlay(fullName: fullName, jobTitle: jobTitle)
                        .padding(
                            EdgeInsets(
                                top: 250,
                                leading: 0,
                                bottom: 0,
                                trailing: 0
                            )
                        )
                )
        }
    }
}
