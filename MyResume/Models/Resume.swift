//
//  Resume.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation

class Resume: Decodable {
    let personalInformations: PersonalInformations
    let experiences: [Experience]
    
    enum CodingKeys: String, CodingKey {
        case personal
        case experiences
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        personalInformations = try container.decode(PersonalInformations.self, forKey: .personal)
        experiences = try container.decode([Experience].self, forKey: .experiences)
    }
}
