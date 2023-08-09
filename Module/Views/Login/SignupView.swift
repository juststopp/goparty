//
//  SignupView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 06/08/2023.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showPassword: Bool = false
    @State private var error: Bool = false
    @State private var errorMessage: String = "Veuillez préciser des identifiants."
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")

        return passwordRegex.evaluate(with: password)
    }
    
    private func isValidUserName(_ username: String) -> Bool {
        let usernameRegex = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9_]{6,32}$")
        
        return usernameRegex.evaluate(with: username)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Créer un compte!")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundStyle(error ? .red : .black)
                
                HStack {
                    Image(systemName: "person")
                    TextField("Nom d'utilisateur", text: $username)
                    
                    Spacer()
                    
                    if username.count != 0 {
                        Image(systemName: isValidUserName(username) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundStyle(isValidUserName(username) ? .green : .red)
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.white)
                )
                .padding()
                
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
                .foregroundStyle(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.white)
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
                            .foregroundStyle(.white)
                            .onTapGesture {
                                showPassword.toggle()
                            }
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.white)
                )
                .padding()
                
                Button(action: {
                    withAnimation {
                        appState.loginView = AppState.LoginView.LOGIN_VIEW
                    }
                }) {
                    Text("Vous avez déjà un compte?")
                }
                
                Spacer()
                Spacer()
                
                Button {
                    if email.count == 0 || password.count == 0 || username.count == 0 {
                        error = true
                        errorMessage = "Veuillez entrer vos identifiants."
                    } else if !isValidUserName(username){
                        error = true
                        errorMessage = "Le nom d'utilisateur est invalide."
                    } else if usersManager.emailExists(email: email) {
                        error = true
                        errorMessage = "L'email est déjà utilisée."
                    } else if !email.isValidEmail() {
                        error = true
                        errorMessage = "L'email entrée est invalide."
                    } else if !isValidPassword(password) {
                        error = true
                        errorMessage = "Le mot de passe ne respecte pas les règles"
                    } else {
                        error = false
                        let user: UserModel = UserModel(id: "\(UUID())",
                                                    name: username,
                                                    email: email,
                                                    password: password)
                        
                        usersManager.createUser(user: user)
                        
                        LocalStorage.add(key: "user_id", value: user.id)
                        LocalStorage.add(key: "user_name", value: user.name)
                        
                        appState.loginView = AppState.LoginView.LOGEDIN_VIEW
                    }
                } label: {
                    Text("Créer un compte")
                        .foregroundStyle(.black)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                        .padding(.horizontal)
                }
            }
        }
    }
}
