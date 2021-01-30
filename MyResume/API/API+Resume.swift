//
//  API+Resume.swift
//  MyResume
//
//  Created by Arthur Kleiber on 19/01/2021.
//

import Foundation
import Combine

extension API {
    static func fetchResume() -> AnyPublisher<APIResponse<Resume>, Error>? {
        guard let url = URL(string: "\(API.ROOT_URL)\(Routes.resume.rawValue)") else {
            return nil
        }
        
        return request(url, method: .get)
    }
    
    static func fetchResumeAsPDF() {
        if let cvPdfUrl = URL(string: API.CV_PDF_URL) {
            API.download(cvPdfUrl) { filePath in
                FileHelper.shared.resumePdfFilePath = filePath
            }
        }
    }
}
