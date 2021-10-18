//
//  Redux_DemoApp.swift
//  Redux_Demo
//
//  Created by Yakun Liu on 18/10/21.
//

import SwiftUI

@main
struct Redux_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ValidationView()
                .environmentObject(AppStore(initialState: .init(), reducer: appReducer, environment: MiddleWare(api: MockAPI())))
        }
    }
}
