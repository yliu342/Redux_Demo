//
//  MiddleWare.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation
import Combine

protocol API {
    func validateUsername(username: String) -> AnyPublisher<Void, Error>
    func validatePassword(password: String) -> AnyPublisher<Void, Error>
    func fetchUsers() -> AnyPublisher<[User], Error>
}

struct MockAPI: API {
    
    func validateUsername(username: String) -> AnyPublisher<Void, Error> {
        if username == "lykxc" {
            return Just(())
                    .setFailureType(to: Error.self)
                    .delay(for: 3, scheduler: RunLoop.main)
                    .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError())
                    .delay(for: 3, scheduler: RunLoop.main)
                    .eraseToAnyPublisher()

        }
    }

    func validatePassword(password: String) -> AnyPublisher<Void, Error> {
        if password == "1234" {
            return Just(())
                    .setFailureType(to: Error.self)
                    .delay(for: 3, scheduler: RunLoop.main)
                    .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError())
                    .delay(for: 3, scheduler: RunLoop.main)
                    .eraseToAnyPublisher()

        }
    }

    func fetchUsers() -> AnyPublisher<[User], Error> {
        Just([User(name: "Mock user"),
              User(name: "User 33")])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

}


// A struct that holds all needed dependencies
struct MiddleWare {
    let api: API
}
