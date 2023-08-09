//
//  GroupChatView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct GroupChatView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @State var group: GroupModel
    @StateObject var appState: AppState
    
    var body: some View {
        VStack {
            VStack {
                TitleRow(group: group, appState: appState)
                    .environmentObject(usersManager)
                    .environmentObject(groupsManager)
                    .environmentObject(messagesManager)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(LocalStorage.getGroupFromId(groupsManager: groupsManager, id: group.id).getOrderedMessages(messagesManager: messagesManager), id: \.self) { m in
                            if m.id != "nil-user" {
                                MessageBubble(message: m)
                                    .environmentObject(usersManager)
                                    .environmentObject(groupsManager)
                                    .environmentObject(messagesManager)
                            }
                        }
                    }
                    .padding(10)
                    .cornerRadius(30, corners: [.topRight, .topLeft])
                    .onChange(of: messagesManager.lastMessageId) { oldId, newId in
                        withAnimation {
                            proxy.scrollTo(newId, anchor: .bottom)
                        }
                    }

                }
            }
            
            MessageField(group: group)
                .environmentObject(usersManager)
                .environmentObject(groupsManager)
                .environmentObject(messagesManager)
        }
    }
}
