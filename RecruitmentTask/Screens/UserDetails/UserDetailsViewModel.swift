//
//  UserDetailsViewModel.swift
//  RecruitmentTask
//
//  Created by gese on 05/09/2021.
//

import Foundation

final class UserDetailsViewModel {
    let fullName: String
    let emailAddress: String

    init(user: User) {
        fullName = "\(user.firstName ?? "") \(user.lastName ?? "")"
        emailAddress = user.email ?? ""
    }
}
