//
//  MessageBubble.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct MessageBubble: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @State var message: MessageModel
    @State var showTime: Bool = false
    
    var body: some View {
        VStack(alignment: message.sender != LocalStorage.getUser(usersManager: usersManager).id ? .leading : .trailing) {
            HStack {
                VStack(alignment: .leading) {
                    if message.sender != LocalStorage.getUser(usersManager: usersManager).id && !message.isSameSenderAsLast {
                        Text(usersManager.users.first(where: { message.sender == $0.id })?.name ?? "Utilisateur introuvale")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.leading)
                    }
                    VStack {
                        Text(message.text)
                    }
                    .padding()
                    .background(message.sender != LocalStorage.getUser(usersManager: usersManager).id ? Color("color_gray") : Color("color_primary"))
                    .cornerRadius(30)
                }
            }
            .frame(maxWidth: 300, alignment: message.sender != LocalStorage.getUser(usersManager: usersManager).id ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption)
                    .foregroundStyle(Color("color_gray"))
                    .padding(message.sender != LocalStorage.getUser(usersManager: usersManager).id ? .leading : .trailing, 15)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.sender != LocalStorage.getUser(usersManager: usersManager).id ? .leading : .trailing)
        .padding(message.sender != LocalStorage.getUser(usersManager: usersManager).id ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}
