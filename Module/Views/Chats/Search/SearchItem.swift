//
//  SearchItem.swift
//  GoParty
//
//  Created by Malo Beaugendre on 07/08/2023.
//

import SwiftUI

struct SearchItem: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    @EnvironmentObject private var friendRequestsManager: FriendRequestsManager
    
    @State var user: UserModel
    
    var body: some View {
        
        HStack {
            
            AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                image.resizable()
                    .background( Color("color_bg_inverted").opacity(0.05))
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            Text(user.name)
                .bold()
            
            Spacer()
            
            let friendRequestTo: Bool = LocalStorage.hasFriendRequestedUser(friendRequestsManager: friendRequestsManager, usersManager: usersManager, receiver: user)
            let friendRequestFrom: FriendRequestModel = LocalStorage.hasFriendRequestFrom(friendRequestsManager: friendRequestsManager, usersManager: usersManager, sender: user)
            
            if LocalStorage.getUser(usersManager: usersManager).friends.contains(user.id) {
                Image(systemName: "xmark")
                    .foregroundStyle(.red)
                    .onTapGesture {
                        var newSenderUser: UserModel = LocalStorage.getUser(usersManager: usersManager)
                        newSenderUser.friends.removeAll(where: { $0 == user.id })
                        
                        var newReceiverUser: UserModel = user;
                        newReceiverUser.friends.removeAll(where: { $0 == newSenderUser.id })
                        
                        user = newReceiverUser
                        
                        usersManager.editUser(userId: newSenderUser.id, newUser: newSenderUser)
                        usersManager.editUser(userId: user.id, newUser: newReceiverUser)
                    }
            } else if friendRequestTo {
                Image(systemName: "clock")
                    .foregroundStyle(.orange)
            } else if friendRequestFrom != LocalStorage.nilFriendRequest {
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(Color("color_primary"))
                    .onTapGesture {
                        var newSenderUser: UserModel = LocalStorage.getUser(usersManager: usersManager)
                        newSenderUser.friends.append(user.id)
                        
                        var newReceiverUser: UserModel = user;
                        newReceiverUser.friends.append(newSenderUser.id)
                        
                        user = newReceiverUser
                        
                        usersManager.editUser(userId: newSenderUser.id, newUser: newSenderUser)
                        usersManager.editUser(userId: user.id, newUser: newReceiverUser)
                        
                        friendRequestsManager.deleteRequest(request: friendRequestFrom)
                    }
                
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.red)
                    .onTapGesture {
                        friendRequestsManager.deleteRequest(request: friendRequestFrom)
                    }
            } else {
                Image(systemName: "plus")
                    .foregroundStyle(Color("color_primary"))
                    .onTapGesture {
                        let friendRequest: FriendRequestModel = FriendRequestModel(id: "\(UUID())", sender: LocalStorage.getString(key: "user_id"), receiver: user.id)
                        friendRequestsManager.createRequest(request: friendRequest)
                    }
            }
            
        }
        .padding()
        
    }
}
