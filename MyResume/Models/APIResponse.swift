//
//  APIResponse.swift
//  MyResume
//
//  Created by Arthur Kleiber on 19/01/2021.
//

import Foundation

struct APIResponse<T> {
    let value: T
    let response: URLResponse
}
