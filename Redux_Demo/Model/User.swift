//
//  User.swift
//  Redux_Demo
//
//  Created by Yakun Liu on 18/10/21.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    var name: String
}

extension User {
    static func fake() -> Self {
        User(name: "Fake user")
    }
}
