//
//  ChatListView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.view == AppState.CurrentView.CHAT_GROUPS_LIST {
                VStack{
                    
                    HStack(alignment: .top){
                        Text("Messages")
                            .fontWeight(.semibold)
                            .font(.largeTitle)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color("color_primary"))
                            .font(.title2)
                            .padding(.top, 10)
                            .onTapGesture {
                                withAnimation {
                                    appState.view = AppState.CurrentView.GROUP_CREATE
                                }
                            }
                    }
                    
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .leading){
                            
                            OnlineUsersView()
                                .environmentObject(usersManager)
                                .environmentObject(groupsManager)
                                .environmentObject(messagesManager)
                           
                            Divider()
                                .padding(.bottom, 20)
                            
                            VStack(spacing: 25){
                                ForEach(LocalStorage.getUserGroups(usersManager: usersManager, groupsManager: groupsManager), id: \.self) { group in
                                    
                                    Button {
                                        LocalStorage.add(key: "group_view_id", value: group.id)
                                        appState.view = AppState.CurrentView.CHAT_GROUPS_CHAT
                                    } label: {
                                        ChatItem(group: group)
                                            .environmentObject(usersManager)
                                            .environmentObject(groupsManager)
                                            .environmentObject(messagesManager)
                                    }

                                
                                }
                            }
                           
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            } else if appState.view == AppState.CurrentView.CHAT_GROUPS_CHAT {
                let group: GroupModel = LocalStorage.getGroupFromId(groupsManager: groupsManager, id: LocalStorage.getString(key: "group_view_id"))
                
                GroupChatView(group: group, appState: appState)
                    .environmentObject(usersManager)
                    .environmentObject(groupsManager)
                    .environmentObject(messagesManager)
            } else if appState.view == AppState.CurrentView.GROUP_CREATE {
                GroupCreateView(appState: appState)
                    .environmentObject(usersManager)
                    .environmentObject(groupsManager)
                    .environmentObject(messagesManager)
            } else if appState.view == AppState.CurrentView.GROUP_INFO {
                GroupInfoView(appState: appState)
                    .environmentObject(usersManager)
                    .environmentObject(groupsManager)
                    .environmentObject(messagesManager)
            }
        }
    }
}
