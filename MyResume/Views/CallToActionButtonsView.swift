//
//  CallToActionButtonsView.swift
//  MyResume
//
//  Created by Arthur Kleiber on 26/01/2021.
//

import Foundation
import SwiftUI


struct CallToSocialButtonsView: View {
    
    @State                  private var shouldShowActivityView = false
    @Environment(\.openURL) private var openURL
    
    let socialNetworks: [SocialNetwork]
    
    enum SocialNetworkType: String {
        case facebook
        case twitter
        case instagram
        case linkedin
        case github
        case website
    }
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(socialNetworks) { socialNetwork in
                RoundActionButton(
                    action: {
                        openURL(URL(string: socialNetwork.link)!)
                    },
                    icon: getSocialNetworkImage(socialNetworkName: socialNetwork.name)
                )
                Spacer()
            }
            RoundActionButton(
                action: {
                    shouldShowActivityView.toggle()
                },
                icon: Image(systemName: "square.and.arrow.up")
            )
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
        .sheet(isPresented: $shouldShowActivityView) {
            ActivityView(activityItems: getActivityItemsToShare(), applicationActivities: nil)
        }
    }
    
    func getSocialNetworkImage(socialNetworkName: String) -> Image {
        let socialNetwork = SocialNetworkType.init(rawValue: socialNetworkName)
        switch socialNetwork {
        case .linkedin:
            return Image("linkedin_logo")
        case .github:
            return Image("github_logo")
        default:
            return Image("")
        }
    }
    
    func getActivityItemsToShare() -> [Any] {
        if let pdfResumeFilePath = FileHelper.shared.resumePdfFilePath, FileHelper.shared.fileExists(filePath: pdfResumeFilePath) {
            return [pdfResumeFilePath]
        } else if let urlToShare = URL(string: LINKEDIN_PROFILE_URL) {
            return [urlToShare]
        }
        
        return []
    }
}
