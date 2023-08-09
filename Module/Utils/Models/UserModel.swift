//
//  UserModel.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation

struct UserModel: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var allergies: [String]
    var public_account: Bool
    var friends: [String]
    
    var email: String
    var password: String
    
    init(id: String, name: String, allergies: [String]? = [], public_account: Bool? = false, friends: [String]? = [], email: String, password: String) {
        self.id = id
        self.name = name
        self.allergies = allergies.unsafelyUnwrapped
        self.public_account = public_account.unsafelyUnwrapped
        self.friends = friends.unsafelyUnwrapped
        
        self.email = email
        self.password = password
    }
}
