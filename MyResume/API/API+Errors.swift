//
//  API+Errors.swift
//  MyResume
//
//  Created by Arthur Kleiber on 19/01/2021.
//

import Foundation

class APIError: Error {
    
    let statusCode: Int
    
    let message: String
    let code: String
    
    init(statusCode: Int, code: String, message: String) {
        self.statusCode = statusCode
        self.code = code
        self.message = message
    }
}

class RessourceNotFoundError: APIError {
    init(code: String, message: String) {
        super.init(statusCode: 404, code: code, message: message)
    }
}
