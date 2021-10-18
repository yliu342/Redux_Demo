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

func appReducer(
    state: inout AppState,
    action: AppAction,
    environment: MiddleWare
) -> AnyPublisher<AppAction, Never>? {
    switch action {
    case let .validatePassword(password):
        state.passWordStatus = .loading
        return environment.api
                .validatePassword(password: password)
                .map({ _ in
                    AppAction.setPasswordValidation(.valid)
                })
                .catch { _ in
                    return Just(AppAction.setPasswordValidation(.invalid(error: "Password Error")))
                }
                .eraseToAnyPublisher()
    case let .validateUserName(userName):
        state.userNameStatus = .loading
        return environment.api
                .validateUsername(username: userName)
                .map({ _ in
                    AppAction.setUserNameValidation(.valid)
                })
                .catch { _ in
                    return Just(AppAction.setUserNameValidation(.invalid(error: "UserName Error")))
                }
                .eraseToAnyPublisher()
    case let .setUserNameValidation(status):
        state.userNameStatus = status
    case let .setPasswordValidation(status):
        state.passWordStatus = status
    }
    
    return nil
}
