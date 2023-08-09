//
//  DatabaseManager.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation
import FirebaseFirestore

class DatabaseManager {
    public static let db: Firestore = Firestore.firestore()
    public static let usersManager: UsersManager = UsersManager()
}
