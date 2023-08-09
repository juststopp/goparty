//
//  MessagesManager.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [MessageModel] = []
    @Published public var isDataFetched: Bool = false
    @Published public var lastMessageId: String = ""
    
    init() {
        createListener()
    }
    
    func createListener() -> Void {
        DatabaseManager.db.collection("messages").addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                return
            }

            DispatchQueue.main.async {
                let messages = snapshot.documents.compactMap { document -> MessageModel? in
                    do {
                        return try document.data(as: MessageModel.self)
                    } catch {
                        print("Error decoding document into Message: \(error)")
                        return nil
                    }
                }
                
                self.messages = messages
                
                self.messages.sort { $0.timestamp < $1.timestamp }
                if let id = self.messages.last?.id {
                    self.lastMessageId = id
                }
                
                self.isDataFetched = true
                
            }
        }
    }
    
    func sendMessage(text: String, user: UserModel) -> MessageModel {
        do {
            let newMessage = MessageModel(id: "\(UUID())", text: text, sender: user.id, timestamp: Date(), isSameSenderAsLast: false)
            try DatabaseManager.db.collection("messages").document(newMessage.id).setData(from: newMessage)
            
            return newMessage
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
        
        return LocalStorage.nilMessage
    }
}
