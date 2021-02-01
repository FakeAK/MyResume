//
//  PortraitImage.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PortraitImage: View {
    var imageLink: String
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: imageLink))
                .resizable()
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .overlay(Color(Colors.blueOverlay))
        }
    }
}
