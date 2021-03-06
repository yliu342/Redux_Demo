//
//  UserContainerView.swift
//  Redux_Demo
//
//  Created by Yakun Liu on 22/10/21.
//

import SwiftUI

// A technique using container view to
// separate data flow and display
struct UserContainerView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        UsersView(users: store.state.userState.users,
                  onDelete: onDelete)
            .onAppear(perform: fetch)
    }

    private func onDelete(_ index: IndexSet) {
        store.send(.user(action: .deleteUserAt(index: index)))
    }

    private func fetch() {
        store.send(.user(action: .fetchUsers))
    }
}

struct UserContainerView_Previews: PreviewProvider {
    static var previews: some View {
        UserContainerView()
    }
}
