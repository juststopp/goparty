//
//  TitleRow.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct TitleRow: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @State var group: GroupModel
    @StateObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "arrow.left")
                .foregroundStyle(.gray)
                .padding(10)
                .cornerRadius(50)
                .onTapGesture {
                    appState.view = AppState.CurrentView.CHAT_GROUPS_LIST
                }
            
            AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            }
            
            VStack(alignment: .leading) {
                Text(group.name)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.title)
                    .bold()
                
                Text(Utils.formatDateEnd(date: group.timestamp))
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            Image(systemName: "info.circle")
                .foregroundStyle(.gray)
                .padding(10)
                .cornerRadius(50)
                .onTapGesture {
                    appState.view = AppState.CurrentView.GROUP_INFO
                }
        }
        .padding()
    }
}
