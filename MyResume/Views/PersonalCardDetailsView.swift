//
//  PersonalCardDetailsView.swift
//  MyResume
//
//  Created by Arthur Kleiber on 22/01/2021.
//

import Foundation
import SwiftUI

struct PersonalCardDetailsView: DismissableView {
    
    var dismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            Text("coucou")
            Button("oui", action: {
                print("ok")
            })
        }.gesture(
            DragGesture()
                .onChanged({ (gesture) in
                    print("ok")
                })
                .onEnded({ (gesture) in
                    self.dismiss?()
                })
        )
    }
}

struct PersonalCardDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        PersonalCardDetailsView()
    }
}
