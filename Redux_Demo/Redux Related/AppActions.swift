//
//  AppActions.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation

enum AppAction {
    // Validation View actions
    case setUserNameValidation(_ validation: ValidationStatus)
    case setPasswordValidation(_ validation: ValidationStatus)
    case validateUserName(userName: String)
    case validatePassword(password: String)

    // User view action
    case fetchUsers
    case setUsers(_ users: [User])
    case deleteUserAt(index: IndexSet)
}
