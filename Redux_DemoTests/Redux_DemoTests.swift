//
//  Redux_DemoTests.swift
//  Redux_DemoTests
//
//  Created by Yakun Liu on 18/10/21.
//

import XCTest
import Combine
@testable import Redux_Demo

typealias AppReducer = (inout AppState, AppAction, MiddleWare) -> AnyPublisher<AppAction, Never>?

class Redux_DemoTests: XCTestCase {
    var appState: AppState!
    var reducer: AppReducer!
    var middleWare: MiddleWare!
    var api: API!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        appState = AppState()
        reducer = appReducer
        api = MockAPI()
        middleWare = MiddleWare(api: api)
    }

    override func tearDown() {
        super.tearDown()
        appState = nil
        reducer = nil
        middleWare = nil
        api = nil
        cancellables = []
    }

    func test_validatePassword_withInvalidPassword_returnCorrectAction() {
        let expectation = XCTestExpectation(description: "expectation")
        let action = AppAction.validation(action: .validatePassword(password: "wrong"))
        reducer(&appState, action, middleWare)!
            .sink { action in
                guard case .validation(action: .setPasswordValidation(.invalid(error: "Password Error"))) = action else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        XCTAssertEqual(appState.regiState.passWordStatus, .loading)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_validatePassword_withValidPassword_returnCorrectAction() {
        let expectation = XCTestExpectation(description: "expectation")
        let action = AppAction.validation(action: .validatePassword(password: "1234"))
        reducer(&appState, action, middleWare)!
            .sink { action in
                guard case .validation(action: .setPasswordValidation(.valid)) = action else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        XCTAssertEqual(appState.regiState.passWordStatus, .loading)
        wait(for: [expectation], timeout: 5.0)
    }

    func test_setPasswordValidation_updateTheStateCorrectly() {
        // Make sure initial state is none
        XCTAssertEqual(appState.regiState.passWordStatus, .none)

        // when reducer runs
        let action = AppAction.validation(action: .setPasswordValidation(.valid))
        let _ = reducer(&appState, action, middleWare)

        XCTAssertEqual(appState.regiState.passWordStatus, .valid)
    }

    func test_fetchUsers_returnCorrectAction() {
        let expectation = XCTestExpectation(description: "expectation")
        let action = AppAction.user(action: .fetchUsers)
        reducer(&appState, action, middleWare)!
            .sink { action in
                guard case .user(action: .setUsers(let users)) = action else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].name, "Mock user")
                XCTAssertEqual(users[1].name, "User 33")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
