//
//  API+Request.swift
//  MyResume
//
//  Created by Arthur Kleiber on 19/01/2021.
//

import Foundation
import Combine

extension API {
    static func request<T: Decodable>(_ url: URL,
                                      method: HTTPMethod,
                                      parameters: [String: Any]? = nil,
                                      _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<APIResponse<T>, Error> {
        var request: URLRequest = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = method.rawValue
//        request.setValue("Bearer \(UserHelper.default.accessToken)", forHTTPHeaderField: HTTPHeaderField.authorization)
        request.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.contentType)
        
        if let parameters = parameters, let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = httpBody
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .tryMap { (data, response) -> APIResponse<T> in
                try handleAPIResponse(response: response)
                let decodedData = try decoder.decode(T.self, from: data)
                return APIResponse(value: decodedData, response: response)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func handleAPIResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError(statusCode: 500, code: "", message: "")
        }
        
        switch httpResponse.statusCode {
        case 404:
            throw RessourceNotFoundError(code: "RESSOURCE.NOT_FOUND", message: "") // replace "" with api message
        default:
            return
        }
    }
}
