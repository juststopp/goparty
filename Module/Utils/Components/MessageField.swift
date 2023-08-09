//
//  MessageField.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @State private var message: String = ""
    @State var group: GroupModel
        
    var body: some View {
        HStack {
            CustomTextField(text: $message, placeholder: Text("Enter your message here"))
            
            Button {
                let messageModel: MessageModel = messagesManager.sendMessage(text: message, user: LocalStorage.getUser(usersManager: usersManager))
                group = groupsManager.sendMessage(messageId: messageModel.id, group: group)
                
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color("color_primary"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("color_gray"))
        .cornerRadius(50)
        .padding()
    }
}

struct CustomTextField: View {
    @Binding var text: String
    
    var placeholder: Text
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

