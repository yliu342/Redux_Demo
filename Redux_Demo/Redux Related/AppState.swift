//
//  AppState.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation

enum ValidationStatus: Equatable {
    case none
    case loading
    case valid
    case invalid(error: String)
}

struct RegistrationState {
    var userNameStatus: ValidationStatus = .none
    var passWordStatus: ValidationStatus = .none
    var allValidationPassed: Bool {
        return userNameStatus == .valid && passWordStatus == .valid
    }
}

struct UserState {
    var users: [User] = []
}


struct AppState {
    var regiState: RegistrationState = RegistrationState()
    var userState: UserState = UserState()
}
