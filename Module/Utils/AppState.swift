//
//  AppState.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import Foundation

class AppState: ObservableObject {
    
    enum CurrentView: Int {
        case CHAT_GROUPS_LIST
        case CHAT_GROUPS_CHAT
        case GROUP_CREATE
        case GROUP_INFO
    }
    
    enum LoginView: Int {
        case LOGIN_VIEW
        case SIGNUP_VIEW
        case LOGEDIN_VIEW
    }
    
    @Published var view: CurrentView = CurrentView.CHAT_GROUPS_LIST
    @Published var loginView: LoginView = LocalStorage.getString(key: "user_id").count != 0 ? LoginView.LOGEDIN_VIEW : LoginView.LOGIN_VIEW
    
}
