//
//  SearchView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 07/08/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    @EnvironmentObject private var friendRequestsManager: FriendRequestsManager
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top){
                Text("Recherche")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                
                Spacer()
            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Rechercher", text: $searchText)
                    .foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(15)
            .foregroundColor(.secondary)
            .background(Color("color_bg_inverted").opacity(0.05))
            .clipShape(Capsule())
            
            ScrollView {
                
                ForEach(Array(usersManager.users.filter({ user in
                    user.name.starts(with: searchText) && user.id != LocalStorage.getString(key: "user_id")
                })).prefix(10)) { user in
                    SearchItem(user: user)
                        .environmentObject(usersManager)
                        .environmentObject(groupsManager)
                        .environmentObject(messagesManager)
                        .environmentObject(friendRequestsManager)
                }
                
            }
            
        }
        .padding()
    }
}
