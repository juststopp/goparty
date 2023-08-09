//
//  SettingsHeaderItem.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct SettingsHeaderItem: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                image.resizable()
                    .background( Color("color_bg").opacity(0.5))
                    .frame(width: 60, height: 60)
                    .overlay(Circle().stroke(Color("color_primary"), lineWidth: 5))
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .background( Color("color_bg").opacity(0.5))
                    .frame(width: 60, height: 60)
                    .overlay(Circle().stroke(Color("color_primary"), lineWidth: 5))
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 6){
                HStack{
                    Text(LocalStorage.getUser(usersManager: usersManager).name)
                        .fontWeight(.semibold)
                        .padding(.top, 3)
                    Spacer()
                }
                
                HStack{
                    Text(LocalStorage.getUser(usersManager: usersManager).email)
                        .foregroundColor(Color("color_bg_inverted").opacity(0.5))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                }
                
                Divider()
                    .padding(.top, 8)
            }
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 20)
    }
}
