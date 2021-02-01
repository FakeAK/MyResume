//
//  Screenshot.swift
//  MyResume
//
//  Created by Arthur Kleiber on 31/01/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ScreenshotImage: View {

    let screenshotLink: String

    var body: some View {
        VStack {
            WebImage(url: URL(string: screenshotLink))
                .resizable()
                .scaledToFit()
                .transition(.fade(duration: 0.5))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color(Colors.shadowScreenshot), radius: 5, x: 0, y: 0)
                .padding(5)
        }
    }
}
