//
//  MessageModel.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation

struct MessageModel: Identifiable, Codable, Hashable {
    var id: String
    var text: String
    var sender: String
    var timestamp: Date
    var isSameSenderAsLast: Bool
    
    init(id: String, text: String, sender: String, timestamp: Date, isSameSenderAsLast: Bool? = false) {
        self.id = id
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
        self.isSameSenderAsLast = isSameSenderAsLast.unsafelyUnwrapped
    }
    
}
