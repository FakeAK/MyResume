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
            .mapError({ (error) -> Error in
                if let error = error as? APIError {
                    return error
                }
                
                return buildError(error)
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func download(_ url: URL, completion: @escaping ((URL) -> ())) {
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            guard let fileLocation = localURL else { return }
            
            let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let destinationPath = docsPath.appendingPathComponent(url.lastPathComponent)
            
            try? FileManager.default.removeItem(at: destinationPath)
            
            do {
                try FileManager.default.copyItem(at: fileLocation, to: destinationPath)
                completion(destinationPath)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    static func handleAPIResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError(statusCode: 500, code: "INTERNAL_ERROR", message: "An internal error occured.")
        }
        
        switch httpResponse.statusCode {
        case 404:
            throw RessourceNotFoundError(code: "RESSOURCE.NOT_FOUND", message: "Ressource not found")
        default:
            return
        }
    }
    
    static func buildError(_ error: Error) -> Error {
        if error is DecodingError {
            return APIError(
                statusCode: 500,
                code: "RESSOURCE.INVALID",
                message: "The data returned by the server is invalid. Failure happened while decoding data."
            )
        }
        
        return error
    }
}
