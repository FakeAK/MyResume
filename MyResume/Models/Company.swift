//
//  Company.swift
//  MyResume
//
//  Created by Arthur Kleiber on 21/01/2021.
//

import Foundation

class Company: Decodable {
    let name: String
    let activity: String
    let website: String?     // link
    let logo: String?        // link
}
