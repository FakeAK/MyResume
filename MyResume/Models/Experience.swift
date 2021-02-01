//
//  Experience.swift
//  MyResume
//
//  Created by Arthur Kleiber on 21/01/2021.
//

import Foundation

class Experience: Decodable {
    let id: Int
    let from: String
    let to: String
    let jobTitle: String
    let company: Company
    let tasksDone: [String]
    let technologiesUsed: [String]
    let screenshots: [Screenshot]?
    let description: String?
}
