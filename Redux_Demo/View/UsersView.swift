//
//  UsersView.swift
//  Redux_Demo
//
//  Created by Yakun Liu on 18/10/21.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        List(store.state.users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                Text(user.name)
            }
        }
        .navigationTitle("Users")
        .onAppear(perform: { store.send(.fetchUsers) })
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}