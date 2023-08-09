//
//  GroupInfoView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 07/08/2023.
//

import SwiftUI

struct GroupInfoView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    var body: some View {
        @State var group: GroupModel = LocalStorage.getGroupFromId(groupsManager: groupsManager, id: LocalStorage.getString(key: "group_view_id"))
        
        VStack {
            
            HStack(alignment: .top) {
                
                Image(systemName: "arrow.left")
                    .foregroundStyle(.gray)
                    .padding(10)
                    .padding(.top, 5)
                    .cornerRadius(50)
                    .onTapGesture {
                        appState.view = AppState.CurrentView.CHAT_GROUPS_CHAT
                    }
                
                Text("Informations")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                
                Spacer()
                
                if group.owner == LocalStorage.getString(key: "user_id") {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                        .padding(10)
                        .padding(.top, 5)
                        .cornerRadius(50)
                        .onTapGesture {
                            groupsManager.deleteGroup(group: group)
                            
                            LocalStorage.delete(key: "group_view_id")
                            appState.view = AppState.CurrentView.CHAT_GROUPS_LIST
                            
                        }
                }
                
            }
            .padding()
            
            ScrollView {
                
                VStack(alignment: .center) {
                    
                    AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                        image.resizable()
                            .background( Color("color_bg_inverted").opacity(0.05))
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    
                    Text(group.name)
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                    
                    
                }
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Image(systemName: "calendar")
                            .font(.largeTitle)
                        
                        Text(Utils.formatDateEnd(date: group.timestamp))
                            .font(.title3)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                    }
                    
                    HStack {
                        
                        Image(systemName: "map")
                            .font(.largeTitle)
                        
                        Text(group.location)
                            .font(.title3)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                    }
                    
                    if group.owner != LocalStorage.getString(key: "user_id") {
                        Button {
                            var newGroup: GroupModel = group
                            newGroup.users.removeAll(where: { $0 == LocalStorage.getString(key: "user_id") })
                            
                            groupsManager.editGroup(groupId: group.id, newGroup: newGroup)
                            
                            LocalStorage.delete(key: "group_view_id")
                            appState.view = AppState.CurrentView.CHAT_GROUPS_LIST
                            
                        } label: {
                            VStack(alignment: .center) {
                                Text("Je ne serais pas présent.")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .padding(5)
                            }
                            .padding()
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .padding(.top, 20)
                        }
                    }
                    
                }
                .padding(.top, 30)
                .padding()
                
                
            }
            .padding()
            
        }
        
    }
}
