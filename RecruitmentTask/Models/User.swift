//
//  User.swift
//  RecruitmentTask
//
//  Created by gese on 04/09/2021.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
