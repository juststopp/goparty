//
//  ContentView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    @EnvironmentObject private var friendRequestsManager: FriendRequestsManager
    
    @StateObject var appState: AppState = AppState()
    
    @State private var moving = false
    
    var body: some View {
        Group {
            if usersManager.isDataFetched && groupsManager.isDataFetched && messagesManager.isDataFetched && friendRequestsManager.isDataFetched {
                if appState.loginView != AppState.LoginView.LOGEDIN_VIEW {
                    AuthView(appState: appState)
                        .environmentObject(usersManager)
                        .environmentObject(groupsManager)
                        .environmentObject(messagesManager)
                } else {
                    TabView {
                        ChatListView(appState: appState)
                            .environmentObject(usersManager)
                            .environmentObject(groupsManager)
                            .environmentObject(messagesManager)
                        
                            .tabItem { Image(systemName: "bubble.left.and.bubble.right") }
                        
                        SearchView()
                            .environmentObject(usersManager)
                            .environmentObject(groupsManager)
                            .environmentObject(messagesManager)
                            .environmentObject(friendRequestsManager)
                        
                            .tabItem { Image(systemName: "magnifyingglass") }
                        
                        SettingsView(appState: appState)
                            .environmentObject(usersManager)
                            .environmentObject(groupsManager)
                            .environmentObject(messagesManager)
                        
                            .tabItem { Image(systemName: "gear") }
                    }
                    .accentColor(Color("color_primary"))
                }
            } else {
                Image("Icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .offset(y: moving ? 0 : 20)
                    .animation(.spring(response: 5, dampingFraction: 0.0, blendDuration: 0.0).repeatForever(autoreverses: false), value: moving)
            }
        }
        .onAppear {
            moving.toggle()
        }
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "color_bg")
        UITabBar.appearance().isTranslucent = false
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error {
                print("Notification access not granted.", error.localizedDescription)
            }
        }
    }
}
