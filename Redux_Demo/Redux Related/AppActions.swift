//
//  AppActions.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation

enum RegistrationActions {
    case setUserNameValidation(_ validation: ValidationStatus)
    case setPasswordValidation(_ validation: ValidationStatus)
    case validateUserName(userName: String)
    case validatePassword(password: String)
}

enum UserActions {
    case fetchUsers
    case setUsers(_ users: [User])
    case deleteUserAt(index: IndexSet)
}

enum AppAction {
    case validation(action: RegistrationActions)
    case user(action: UserActions)
}
