//
//  OnlineUsersView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct OnlineUsersView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            VStack{
                HStack(spacing:25){
                    ForEach(LocalStorage.getFriends(usersManager: usersManager), id: \.self) { user in
                        VStack{
                            AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                                image.resizable()
                                    .background( Color("color_bg").opacity(0.1))
                                    .frame(width: 60, height: 60)
                                    .overlay(Circle().stroke(Color("color_primary"), lineWidth: 5))
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .background( Color("color_bg").opacity(0.1))
                                    .frame(width: 60, height: 60)
                                    .overlay(Circle().stroke(Color("color_primary"), lineWidth: 5))
                                    .clipShape(Circle())
                            }
                            Text("\(user.name)")
                                .padding(.top, 3)
                        }
                    }
                }
            }
            .padding(.vertical, 20)
        }
    }
}
