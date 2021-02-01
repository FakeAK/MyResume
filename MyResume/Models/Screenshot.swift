//
//  Screenshot.swift
//  MyResume
//
//  Created by Arthur Kleiber on 01/02/2021.
//

import Foundation

enum Axis: String {
    case vertical
    case horizontal
}

class Screenshot: Decodable {
    let axis: Axis
    let links: [String]
    
    enum CodingKeys: String, CodingKey {
        case axis
        case links
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let axisString = try container.decode(String.self, forKey: .axis)
        axis = Axis.init(rawValue: axisString) ?? .vertical
        links = try container.decode([String].self, forKey: .links)
    }
}
