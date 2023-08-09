//
//  GroupsManager.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class GroupsManager: ObservableObject {
    @Published private(set) var groups: [GroupModel] = []
    @Published public var isDataFetched: Bool = false
    
    init() {
        createListener()
    }
    
    func createListener() -> Void {
        DatabaseManager.db.collection("groups").addSnapshotListener { [weak self] (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                return
            }

            DispatchQueue.main.async {
                let groups = snapshot.documents.compactMap { document -> GroupModel? in
                    do {
                        return try document.data(as: GroupModel.self)
                    } catch {
                        print("Error decoding document into Group: \(error)")
                        return nil
                    }
                }
                self?.groups = groups
                self?.isDataFetched = true
            }
        }
    }
    
    func sendMessage(messageId: String, group: GroupModel) -> GroupModel {
        do {
            var newGroup: GroupModel = group
            newGroup.messages.append(messageId)
            
            try DatabaseManager.db.collection("groups").document(group.id).setData(from: newGroup)
            return newGroup
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
        return group
    }
    
    func createGroup(group: GroupModel) -> Void {
        do {
            try DatabaseManager.db.collection("groups").document(group.id).setData(from: group)
        } catch {
            print("Error while creating Group: \(error)")
        }
    }
    
    func editGroup(groupId: String, newGroup: GroupModel) {
        do {
            try DatabaseManager.db.collection("groups").document(groupId).setData(from: newGroup)
        } catch {
            print("Error while editing the group: \(error)")
        }
    }
    
    func deleteGroup(group: GroupModel) -> Void {
        DatabaseManager.db.collection("groups").document(group.id).delete()
    }
}
