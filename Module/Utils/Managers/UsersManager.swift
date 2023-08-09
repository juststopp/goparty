//
//  UsersManager.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UsersManager: ObservableObject {
    @Published private(set) var users: [UserModel] = []
    @Published public var isDataFetched: Bool = false
    
    init() {
        createListener()
    }
    
    func createListener() -> Void {
        DatabaseManager.db.collection("users").addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                return
            }

            DispatchQueue.main.async {
                let users = snapshot.documents.compactMap { document -> UserModel? in
                    do {
                        return try document.data(as: UserModel.self)
                    } catch {
                        print("Error decoding document into User: \(error)")
                        return nil
                    }
                }
                self.users = users
                self.isDataFetched = true
            }
        }
    }
    
    func createUser(user: UserModel) -> Void {
        do {
            try DatabaseManager.db.collection("users").document(user.id).setData(from: user)
            print("User created!")
        } catch {
            print("Error while creating the user: \(error)")
        }
    }
    
    func emailExists(email: String) -> Bool {
        return self.users.first(where: { $0.email == email }) != nil
    }
    
    func isCredentialsValid(email: String, password: String) -> Bool {
        return self.users.first(where: { $0.email == email && $0.password == password }) != nil
    }
    
    func editUser(userId: String, newUser: UserModel) {
        do {
            try DatabaseManager.db.collection("users").document(userId).setData(from: newUser)
        } catch {
            print("Error while editing the user: \(error)")
        }
    }
    
    func deleteUser(user: UserModel) -> Void {
        DatabaseManager.db.collection("users").document(user.id).delete()
    }
}
