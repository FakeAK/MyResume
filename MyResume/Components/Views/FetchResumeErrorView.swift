//
//  FetchResumeErrorView.swift
//  MyResume
//
//  Created by Arthur Kleiber on 02/02/2021.
//

import SwiftUI

struct FetchResumeErrorView: View {
    
    let message: String
    
    var body: some View {
        VStack(alignment: .center) {
            LottieView(name: "Error")
            Text(message.uppercased())
                .padding(.horizontal, 20)
                .font(Font.system(size: 15, weight: .bold))
                .foregroundColor(Color(Colors.titleTextColor))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
