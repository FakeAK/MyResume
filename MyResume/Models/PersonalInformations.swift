//
//  PersonalInformations.swift
//  MyResume
//
//  Created by Arthur Kleiber on 19/01/2021.
//

import Foundation

class PersonalInformations: Decodable {
    let firstName: String
    let lastName: String
    let jobTitle: String
    let photo: String
    let contact: Contact
    let socialNetworks: [SocialNetwork]
}
