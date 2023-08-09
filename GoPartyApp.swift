//
//  GoPartyApp.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import SwiftUI
import Firebase

@main
struct GoPartyApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var usersManager = UsersManager()
    @StateObject private var groupsManager = GroupsManager()
    @StateObject private var messagesManager = MessagesManager()
    @StateObject private var friendRequestsManager = FriendRequestsManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(usersManager)
                .environmentObject(groupsManager)
                .environmentObject(messagesManager)
                .environmentObject(friendRequestsManager)
        }
    }
}
