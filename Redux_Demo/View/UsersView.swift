//
//  UsersView.swift
//  Redux_Demo
//
//  Created by Yakun Liu on 18/10/21.
//

import SwiftUI

struct UsersView: View {
    let users: [User]
    let onDelete: (IndexSet) -> Void

    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    Text(user.name)
                }
            }
            .onDelete(perform: onDelete)
        }
        .navigationTitle("Users")
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(users: [User.fake(), User.fake()], onDelete: {_ in })
    }
}
