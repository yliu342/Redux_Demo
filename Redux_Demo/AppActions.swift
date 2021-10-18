//
//  AppActions.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation

enum AppAction {
    case setUserNameValidation(_ validation: ValidationStatus)
    case setPasswordValidation(_ validation: ValidationStatus)
    case validateUserName(userName: String)
    case validatePassword(password: String)
}
