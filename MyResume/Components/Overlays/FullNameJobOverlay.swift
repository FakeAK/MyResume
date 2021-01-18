//
//  FullNameJobOverlay.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import SwiftUI

struct FullNameJobOverlay: View {
    var fullName: String
    var jobTitle: String
    
    var body: some View {
        ZStack {
            VStack {
                Text(fullName)
                    .font(.title)
                    .foregroundColor(.white)
                Text(jobTitle)
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
    }
}
