//
//  UsersViewModel.swift
//  RecruitmentTask
//
//  Created by gese on 04/09/2021.
//

import Foundation

final class UsersViewModel {
    private let userService: UserService

    var reloadTableView: (() -> Void)?
    var showError: ((NetworkError) -> Void)?

    var users: [User] = [] {
        didSet {
            reloadTableView?()
        }
    }

    init(userService: UserService = RealUserService(session: URLSession.shared)) {
        self.userService = userService
    }

    func queryUsers() {
        userService.queryUsers { [weak self] result in

            switch result {
            case let .success(users):
                self?.users = users
            case let .failure(error):
                print(error.localizedDescription)
                self?.showError?(error)
            }
        }
    }

    func getFullName(at indexPath: IndexPath) -> String {
        let user = users[indexPath.row]
        return "\(user.firstName ?? "") \(user.lastName ?? "")"
    }
}
