//
//  SettingsView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    var body: some View {
        VStack{
            HStack{
                Text("Paramètres")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                Spacer()
            }
            
            ScrollView{

                SettingsHeaderItem()
                    .environmentObject(usersManager)
                    .environmentObject(groupsManager)
                    .environmentObject(messagesManager)
     
                SettingsItem(icon: "person", title: "Compte")
                SettingsItem(icon: "bell", title: "Sons & Notifications")
                SettingsItem(icon: "lock", title: "Confidentialité & Sécurité")
                SettingsItem(icon: "globe", title: "Langue", selectedValue: "English")
                SettingsItem(icon: "arrow.left", title: "Se déconnecter", noChevron: true)
                    .onTapGesture {
                        appState.loginView = AppState.LoginView.LOGIN_VIEW
                        LocalStorage.delete(key: "user_id")
                    }
            }
            .padding(.vertical)

        }
        .padding()
    }
}
