//
//  ChatItem.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import SwiftUI

struct ChatItem: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    var group: GroupModel
    
    @State var lastMessage: MessageModel = LocalStorage.nilMessage
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                image.resizable()
                    .background( Color("color_bg_inverted").opacity(0.05))
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading){
                HStack{
                    Text(group.name)
                        .fontWeight(.semibold)
                        .padding(.top, 3)
                    Spacer()
                    
                    Text(Utils.formatDateHour(date: LocalStorage.getMessageFromId(messagesManager: messagesManager, id: group.messages.last ?? "nil-message").timestamp))
                        .foregroundColor(Color("color_primary"))
                        .padding(.top, 3)
                }
                
                
                Text(LocalStorage.getMessageFromId(messagesManager: messagesManager, id: group.messages.last ?? "nil-message").text)
                    .foregroundColor(Color("color_bg_inverted").opacity(0.5))
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .truncationMode(.tail)
                Divider()
                    .padding(.top, 8)
            }
            .padding(.horizontal, 10)
        }
    }
}
