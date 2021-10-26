//
//  Reducer.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation
import Combine

typealias Reducer<State, Action, Environment> =
    (inout State, Action, Environment) -> AnyPublisher<Action, Never>?


func validationReducer(
    state: inout RegistrationState,
    action: RegistrationActions,
    environment: MiddleWare
) -> AnyPublisher<RegistrationActions, Never>? {
    switch action {
    case let .validatePassword(password):
        state.passWordStatus = .loading
        return environment.api
                .validatePassword(password: password)
                .map({ _ in
                    RegistrationActions.setPasswordValidation(.valid)
                })
                .catch { _ in
                    return Just(RegistrationActions.setPasswordValidation(.invalid(error: "Password Error")))
                }
                .eraseToAnyPublisher()
    case let .validateUserName(userName):
        state.userNameStatus = .loading
        return environment.api
                .validateUsername(username: userName)
                .map({ _ in
                    RegistrationActions.setUserNameValidation(.valid)
                })
                .catch { _ in
                    return Just(RegistrationActions.setUserNameValidation(.invalid(error: "UserName Error")))
                }
                .eraseToAnyPublisher()
    case let .setUserNameValidation(status):
        state.userNameStatus = status
    case let .setPasswordValidation(status):
        state.passWordStatus = status
    }

    return nil
}

func userReducer(
    state: inout UserState,
    action: UserActions,
    environment: MiddleWare
) -> AnyPublisher<UserActions, Never>? {
    switch action {
    case .fetchUsers:
        return environment.api
                .fetchUsers()
                .replaceError(with: [])
                .map({ UserActions.setUsers($0)})
                .eraseToAnyPublisher()
    case let .setUsers(users):
        state.users = users
    case let .deleteUserAt(index):
        state.users.remove(atOffsets: index)
    }

    return nil
}


func appReducer(
    state: inout AppState,
    action: AppAction,
    environment: MiddleWare
) -> AnyPublisher<AppAction, Never>? {
    switch action {
    case .validation(let action):
        if let result = validationReducer(state: &state.regiState, action: action, environment: environment) {
            return result.map(AppAction.validation)
                .eraseToAnyPublisher()
        }

    case .user(let action):
        if let result = userReducer(state: &state.userState, action: action, environment: environment) {
            return result.map(AppAction.user)
                .eraseToAnyPublisher()
        }
    }
    return nil
}
