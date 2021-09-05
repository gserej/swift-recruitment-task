//
//  UsersViewModelTests.swift
//  RecruitmentTaskTests
//
//  Created by gese on 05/09/2021.
//

import Foundation
@testable import RecruitmentTask
import XCTest

class UsersViewModelTests: XCTestCase {
    var viewModel: UsersViewModel!
    var userService: MockUserService!

    let mockedUser = User(id: 1, email: nil, firstName: "John", lastName: "Green", avatar: nil)

    override func tearDown() {
        viewModel = nil
        userService = nil
        super.tearDown()
    }

    func testFailedQuery() {
        // given user service will return failure and array of users is initialy empty

        userService = MockUserService()
        userService.returnedUsers = nil

        viewModel = UsersViewModel(userService: userService)

        XCTAssertEqual(viewModel.users.count, 0)

        // when query function is called
        viewModel.queryUsers()

        // then array of users remains empty
        XCTAssertEqual(viewModel.users.count, 0)
    }

    func testSuccesfulQuery() {
        // given user service will return success with one user and array of users is initialy empty

        userService = MockUserService()
        userService.returnedUsers = [mockedUser]

        viewModel = UsersViewModel(userService: userService)

        XCTAssertEqual(viewModel.users.count, 0)

        // when query function is called
        viewModel.queryUsers()

        // then array of users gets updated
        XCTAssertEqual(viewModel.users.count, 1)
    }

    func testNameFormatter() {
        viewModel = UsersViewModel()

        // given there is a user in array
        viewModel.users = [mockedUser]

        // when getFullName is called
        let formattedName = viewModel.getFullName(at: IndexPath(row: 0, section: 0))

        // then name is formated
        XCTAssertEqual(formattedName, "John Green")
    }
}
