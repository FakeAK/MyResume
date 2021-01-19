//
//  ResumeViewModel.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation
import Combine

class ResumeViewModel: ObservableObject {
    
    @Published var resume: Resume?
    
    var subscriber: AnyCancellable? = nil
    var publisher: AnyPublisher<APIResponse<Resume>, Error>? = nil
    
    func fetchResume() {
        publisher = API.fetchResume()
        subscriber = publisher?.sink(receiveCompletion: { (completion) in
            switch (completion) {
            case .failure(let error):
                self.handleFetchError(error: error)
            case .finished:
                break
            }
        }, receiveValue: { (data) in
            self.resume = data.value
        })
    }
    
    func handleFetchError(error: Error) {
        
    }
}
