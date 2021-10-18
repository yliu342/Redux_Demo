//
//  UserDetailView.swift
//  Redux_Demo
//
//  Created by Yakun Liu on 18/10/21.
//

import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject var store: AppStore
    let user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        Text(user.name)
            .navigationTitle("Hello :)")
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User.fake())
    }
}
