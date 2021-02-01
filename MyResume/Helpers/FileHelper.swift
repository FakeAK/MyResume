//
//  FileHelper.swift
//  MyResume
//
//  Created by Arthur Kleiber on 28/01/2021.
//

import Foundation

class FileHelper {
    static let shared = FileHelper()
    
    var resumePdfFilePath: URL?
    
    func fileExists(filePath: URL?) -> Bool {
        guard let filePath = filePath else { return false }
        return FileManager.default.fileExists(atPath: filePath.path)
    }
}
