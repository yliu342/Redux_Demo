//
//  ContentView.swift
//  Demo Redux
//
//  Created by Yakun Liu on 18/10/21.
//

import SwiftUI

struct ValidationView: View {
    @EnvironmentObject var store: AppStore
    @State private var userName: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Enter UsernName", text: $userName) { isEditing in
                    if !isEditing {
                        store.send(.validation(action: .validateUserName(userName: userName)))
                    }
                } onCommit: {
                    store.send(.validation(action: .validateUserName(userName: userName)))
                }
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 50)
                .textFieldStyle(.roundedBorder)

                switch store.state.regiState.userNameStatus {
                case .loading:
                    Text("Loading")
                case .none:
                    Text("none")
                case .valid:
                    Text("valid")
                case let .invalid(error):
                    Text(error)
                }

                TextField("Enter Password", text: $password) { isEditing in
                    if !isEditing {
                        store.send(.validation(action: .validatePassword(password: password)))
                    }
                } onCommit: {
                    store.send(.validation(action: .validatePassword(password: password)))
                }
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 50)
                .textFieldStyle(.roundedBorder)

                switch store.state.regiState.passWordStatus {
                case .loading:
                    Text("Loading")
                case .none:
                    Text("none")
                case .valid:
                    Text("valid")
                case let .invalid(error):
                    Text(error)
                }
                Spacer()

                NavigationLink(destination: UserContainerView()) {
                    Text("User View")
                }
                .disabled(!store.state.regiState.allValidationPassed)

            }
            .navigationTitle("Validation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationView()
            .environmentObject(AppStore(initialState: .init(), reducer: appReducer, environment: MiddleWare(api: MockAPI())))
    }
}
