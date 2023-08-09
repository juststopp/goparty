//
//  AuthView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    var body: some View {
        if appState.loginView == AppState.LoginView.LOGIN_VIEW {
            LoginView(appState: appState)
                .environmentObject(usersManager)
                .environmentObject(groupsManager)
                .environmentObject(messagesManager)
            
                .preferredColorScheme(.light)
        } else {
            SignupView(appState: appState)
                .environmentObject(usersManager)
                .environmentObject(groupsManager)
                .environmentObject(messagesManager)
            
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
    }
}
