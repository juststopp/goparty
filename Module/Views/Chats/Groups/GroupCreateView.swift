//
//  GroupCreateView.swift
//  GoParty
//
//  Created by Malo Beaugendre on 07/08/2023.
//

import SwiftUI

struct GroupCreateView: View {
    @EnvironmentObject private var usersManager: UsersManager
    @EnvironmentObject private var groupsManager: GroupsManager
    @EnvironmentObject private var messagesManager: MessagesManager
    
    @StateObject var appState: AppState
    
    @State var searchText: String = ""
    @State var userSearchText: String = ""
    
    @State var name: String = ""
    @State var location: String = ""
    @State var date: Date = Date()
    @State var thingsToBrought: [String] = []
    @State var users: [String] = []
    
    var body: some View {
        VStack{
            
            HStack(alignment: .top){
                Image(systemName: "arrow.left")
                    .foregroundStyle(.gray)
                    .padding(10)
                    .padding(.top, 5)
                    .cornerRadius(50)
                    .onTapGesture {
                        appState.view = AppState.CurrentView.CHAT_GROUPS_LIST
                    }
                
                Text("Créer un groupe")
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                Spacer()
                
                Text("Créer")
                    .foregroundStyle(Color("color_primary"))
                    .padding(.top, 15)
                    .onTapGesture {
                        users.append(LocalStorage.getString(key: "user_id"))
                        
                        let group: GroupModel = GroupModel(id: "\(UUID())", name: name, owner: LocalStorage.getString(key: "user_id"), users: users, messages: [], location: location, timestamp: date)
                        groupsManager.createGroup(group: group)
                        
                        withAnimation {
                            appState.view = AppState.CurrentView.CHAT_GROUPS_LIST
                        }
                    }
            }
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading) {
                        Text("Nom")
                            .font(.headline)
                        
                        ZStack {
                            Color("color_gray")
                            TextField("Le nom du groupe", text: $name)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Lieu")
                            .font(.headline)
                        
                        ZStack {
                            Color("color_gray")
                            TextField("Où ça se déroule?", text: $location)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Date")
                            .font(.headline)
                        
                        HStack {
                            DatePicker("La date de l'évènement", selection: $date, in: Date.now...)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Nourriture & Boissons")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Chips, Alcool, Soft...", text: $searchText)
                                .foregroundColor(.primary)
                            
                            Button(action: {
                                thingsToBrought.append(searchText)
                                self.searchText = ""
                            }) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundStyle(Color("color_primary"))
                                    .opacity(searchText == "" ? 0 : 1)
                            }
                        }
                        .padding()
                        
                        ForEach(thingsToBrought, id: \.self) { thing in
                            HStack {
                                Text(thing)
                                    .font(.headline)
                                
                                Spacer()
                                    
                                Image(systemName: "xmark")
                                    .foregroundStyle(.red)
                                    .onTapGesture {
                                        thingsToBrought.removeAll(where: { $0 == thing })
                                    }
                            }
                            .padding()
                        }
                    }
                    .padding()
                    
                    Divider()
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Utilisateurs")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Nom", text: $userSearchText)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        
                        ForEach(Array(LocalStorage.getFriends(usersManager: usersManager).filter({ user in
                            user.id != LocalStorage.getString(key: "user_id") && user.name.starts(with: userSearchText)
                        })).prefix(10), id: \.self) { user in
                            HStack {
                                AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                                    image.resizable()
                                        .background( Color("color_bg_inverted").opacity(0.05))
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                }
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(user.name)
                                            .fontWeight(.semibold)
                                            .padding(.top, 3)
                                        Spacer()
                                        
                                        if users.contains(where: { $0 == user.id }) {
                                            Image(systemName: "xmark.circle")
                                                .foregroundColor(.red)
                                                .padding(.top, 3)
                                                .onTapGesture {
                                                    users.removeAll(where: { $0 == user.id })
                                                }
                                        } else {
                                            Image(systemName: "plus.circle")
                                                .foregroundColor(Color("color_primary"))
                                                .padding(.top, 3)
                                                .onTapGesture {
                                                    users.append(user.id)
                                                }
                                        }
                                    }
                                    
                                    Divider()
                                        .padding(.top, 8)
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding()
                   
                }
                .padding(.top, 20)
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}
