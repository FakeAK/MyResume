//
//  Resume.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation

class Resume: Decodable {
    let personalInformations: PersonalInformations
    
    enum CodingKeys: String, CodingKey {
        case personal
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        personalInformations = try container.decode(PersonalInformations.self, forKey: .personal)
    }
}
