//
//  FriendRequestsManager.swift
//  GoParty
//
//  Created by Malo Beaugendre on 07/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FriendRequestsManager: ObservableObject {
    @Published private(set) var requests: [FriendRequestModel] = []
    @Published public var isDataFetched: Bool = false
    
    init() {
        createListener()
    }
    
    func createListener() -> Void {
        DatabaseManager.db.collection("friend_requests").addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                return
            }

            DispatchQueue.main.async {
                let requests = snapshot.documents.compactMap { document -> FriendRequestModel? in
                    do {
                        return try document.data(as: FriendRequestModel.self)
                    } catch {
                        print("Error decoding document into Friend Request: \(error)")
                        return nil
                    }
                }
                self.requests = requests
                self.isDataFetched = true
            }
        }
    }
    
    func createRequest(request: FriendRequestModel) -> Void {
        do {
            try DatabaseManager.db.collection("friend_requests").document(request.id).setData(from: request)
            print("Friend Request created!")
        } catch {
            print("Error while creating the user: \(error)")
        }
    }
    
    func deleteRequest(request: FriendRequestModel) -> Void {
        DatabaseManager.db.collection("friend_requests").document(request.id).delete()
    }
}
