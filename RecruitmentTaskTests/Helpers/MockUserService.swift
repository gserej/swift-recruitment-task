//
//  MockUserService.swift
//  RecruitmentTaskTests
//
//  Created by gese on 05/09/2021.
//

import Foundation
@testable import RecruitmentTask

final class MockUserService: UserService {
    var returnedUsers: [User]?

    func queryUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        if let users = returnedUsers {
            completion(Result.success(users))
        } else {
            completion(Result.failure(NetworkError.serverError("Could not load data")))
        }
    }
}
