//
//  LoginView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showPassword: Bool = false
    @State private var error: Bool = false
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")

        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Bon retour!")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                Text("Les identifiants ne semblent pas corrects.")
                    .font(.subheadline)
                    .foregroundStyle(error ? .red : .white)
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    
                    Spacer()
                    
                    if email.count != 0 {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundStyle(email.isValidEmail() ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.black)
                )
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    
                    if !showPassword {
                        SecureField("Mot de passe", text: $password)
                    } else {
                        TextField("Mot de passe", text: $password)
                    }
                    
                    Spacer()
                    
                    if password.count != 0 {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                showPassword.toggle()
                            }
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.black)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        appState.loginView = AppState.LoginView.SIGNUP_VIEW
                    }
                }) {
                    Text("Vous n'avez pas de compte?")
                }
                
                Spacer()
                Spacer()
                
                Button {
                    if usersManager.isCredentialsValid(email: email, password: password) {
                        error = false
                        LocalStorage.add(key: "user_id", value: usersManager.users.first(where: { email == $0.email && password == $0.password } )!.id)
                        LocalStorage.add(key: "user_name", value: usersManager.users.first(where: { email == $0.email && password == $0.password } )!.name)
                        
                        
                        appState.loginView = AppState.LoginView.LOGEDIN_VIEW
                    } else {
                        error = true
                    }
                } label: {
                    Text("Se connecter")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                        )
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
        }
    }
}
