//
//  ExperienceCardDetailsView.swift
//  MyResume
//
//  Created by Arthur Kleiber on 31/01/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct ExperienceCardDetailsView: DismissableView {
    
    @State private var animationAmount: CGFloat = 0
    @State private var offset = CGFloat.zero
    let experience: Experience
    
    var dismiss: (() -> Void)?
    
    var body: some View {
        GeometryReader { view in
            ScrollView {
                VStack {
                    
                    // MARK: - HEADER CENTERED HORIZONTALLY
                    ExperienceHeader(experience: experience)
                    
                    // MARK: - LEFT ALIGNED CONTENT
                    VStack(alignment: .leading) {
                        if let description = experience.description {
                            Text(description)
                                .padding(.horizontal, 20)
                                .font(Font.custom("PlayfairDisplay-Regular", size: 15))
                                .foregroundColor(Color(Colors.textColor))
                        }
                        
                        if experience.tasksDone.count > 0 {
                            Group {
                                Text("TASKS DONE")
                                    .underline()
                                    .font(Font.system(size: 17))
                                    .foregroundColor(Color(Colors.textColor))
                                    .padding(.top, 20)
                                ForEach(experience.tasksDone, id: \.self) { task in
                                    HStack(alignment: .top) {
                                        Text("•")
                                            .padding(.top, 2)
                                        Text("\(task)")
                                            .font(Font.system(size: 14))
                                            .foregroundColor(Color(Colors.textColor))
                                            .padding(.vertical, 5)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        if experience.technologiesUsed.count > 0 {
                            Group {
                                Text("TECHNOLOGIES USED")
                                    .underline()
                                    .font(Font.system(size: 17))
                                    .foregroundColor(Color(Colors.textColor))
                                    .padding(.top, 20)
                                ForEach(experience.technologiesUsed, id: \.self) { technologyUsed in
                                    HStack(alignment: .top) {
                                        Text("•")
                                            .padding(.top, 2)
                                        Text("\(technologyUsed)")
                                            .font(Font.system(size: 14))
                                            .foregroundColor(Color(Colors.textColor))
                                            .padding(.vertical, 5)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        if let screenshots = experience.screenshots, screenshots.count > 0 {
                            Text("SCREENSHOTS")
                                .underline()
                                .font(Font.system(size: 17))
                                .foregroundColor(Color(Colors.textColor))
                                .padding(.top, 20)
                                .padding(.horizontal, 20)
                            
                            ForEach(screenshots, id: \.axis) { screenshot in
                                let screenshotAxis = screenshot.axis
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(screenshot.links, id: \.self) { screenshot in
                                            if screenshotAxis == .vertical {
                                                ScreenshotImage(screenshotLink: screenshot)
                                                    .frame(width: 225, height: 400, alignment: .center)
                                            } else {
                                                ScreenshotImage(screenshotLink: screenshot)
                                                    .frame(width: 350, height: 200, alignment: .center)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top, 20)
                    
                    // MARK: - Website Centered Button
                    VStack(alignment: .center) {
                        LinkButton(link: experience.company.website)
                    }
                    .padding(20)
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
        .onAppear {
            self.animationAmount = 1
        }
    }
}

//struct PersonalCardDetailsView_Preview: PreviewProvider {
//    static var previews: some View {
//        PersonalCardDetailsView(personalInformations: PersonalInformations())
//    }
//}
