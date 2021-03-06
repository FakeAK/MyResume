//
//  File.swift
//  MyResume
//
//  Created by Arthur Kleiber on 19/01/2021.
//

import Foundation

class API {
    
    static let ROOT_URL = "https://09794fa8-c435-4492-8d8d-37fe033c538e.mock.pstmn.io"
    static let CV_PDF_URL = "https://cv-pool-bucket.s3.eu-west-3.amazonaws.com/arthurkleiber/CV_Arthur_Kleiber_2021_EN.pdf"
    
    enum HTTPMethod: String {
        case post
        case get
        case put
        case delete
    }
    
    typealias HTTPHeaders = [String: String]
    static var headers: HTTPHeaders = [
        HTTPHeaderField.contentType: "application/json"
    ]

    struct HTTPHeaderField {
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
        static let acceptEncoding = "Accept-Encoding"
        static let cookie = "Cookie"
    }

    struct ContentType {
        static let json = "application/json"
        static let multipart = "multipart/form-data"
        static let urlEncoded = "application/x-www-form-urlencoded"
    }
}
