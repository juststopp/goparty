//
//  GroupModel.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation

struct GroupModel: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var owner: String
    
    var users: [String]
    var messages: [String]
    
    var location: String
    var thingsToBrought: [String] = []
    
    var timestamp: Date
    
    init(id: String, name: String, owner: String, users: [String], messages: [String], location: String, timestamp: Date) {
        self.id = id
        self.name = name
        self.owner = owner
        self.users = users
        self.messages = messages
        self.location = location
        self.timestamp = timestamp
    }
    
    func getOrderedMessages(messagesManager: MessagesManager) -> [MessageModel] {
        var lastSenderId: String = ""
        
        return self.messages.map { id in
            var temp = LocalStorage.getMessageFromId(messagesManager: messagesManager, id: id)
             
             if temp.sender == lastSenderId {
                 temp.isSameSenderAsLast = true
             }
             
             lastSenderId = temp.sender
             
             return temp
         }
    }
    
}


