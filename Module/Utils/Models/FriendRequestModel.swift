//
//  FriendRequestModel.swift
//  GoParty
//
//  Created by Malo Beaugendre on 07/08/2023.
//

import Foundation

struct FriendRequestModel: Identifiable, Codable, Hashable {
    var id: String
    var sender: String
    var receiver: String
    
    init(id: String, sender: String, receiver: String) {
        self.id = id
        self.sender = sender
        self.receiver = receiver
    }
    
}
