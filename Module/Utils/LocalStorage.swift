//
//  LocalStorage.swift
//  GoParty
//
//  Created by Malo Beaugendre on 05/08/2023.
//

import Foundation

class LocalStorage {
    
    public static let nilUser: UserModel = UserModel(id: "nil-user", name: "nil-user", email: "nil-user", password: "nil-user")
    public static let nilMessage: MessageModel = MessageModel(id: "nil-messages", text: "Aucun message", sender: "nil-user", timestamp: Date())
    public static let nilGroup: GroupModel = GroupModel(id: "nil-group", name: "nil-group", owner: "nil-group", users: [], messages: [], location: "nil-group", timestamp: Date())
    public static let nilFriendRequest: FriendRequestModel = FriendRequestModel(id: "nil-request", sender: "nil-user", receiver: "nil-user")
    
    static func add(key: String, value: String) -> Void { UserDefaults.standard.set(value, forKey: key) }
    static func get(key: String) -> AnyObject { UserDefaults.standard.object(forKey: key) as AnyObject }
    static func getString(key: String) -> String { UserDefaults.standard.string(forKey: key) ?? "" }
     
    static func delete(key: String) -> Void { UserDefaults.standard.removeObject(forKey: key) }
    
    static func getUser(usersManager: UsersManager) -> UserModel { return usersManager.users.first(where: { $0.id == getString(key: "user_id") }) ?? nilUser }
    static func getUserGroups(usersManager: UsersManager, groupsManager: GroupsManager) -> [GroupModel] {
        var groups: [GroupModel] = groupsManager.groups.filter { $0.users.contains(getUser(usersManager: usersManager).id) }
        groups.sort { $0.timestamp > $1.timestamp }
        return groups
    }
    
    static func getFriends(usersManager: UsersManager) -> [UserModel] {
        return usersManager.users.filter { $0.friends.contains(getUser(usersManager: usersManager).id) && getUser(usersManager: usersManager).friends.contains($0.id) }
    }
    
    static func getUserFromId(usersManager: UsersManager, id: String) -> UserModel { return usersManager.users.first(where: { $0.id == id }) ?? nilUser }
    static func getMessageFromId(messagesManager: MessagesManager, id: String) -> MessageModel { return messagesManager.messages.first(where: { $0.id == id }) ?? nilMessage }
    static func getGroupFromId(groupsManager: GroupsManager, id: String) -> GroupModel { return groupsManager.groups.first(where: { $0.id == id }) ?? nilGroup }
    
    static func hasFriendRequestedUser(friendRequestsManager: FriendRequestsManager, usersManager: UsersManager, receiver: UserModel) -> Bool {
        return (friendRequestsManager.requests.first(where: { $0.receiver == receiver.id && $0.sender == getUser(usersManager: usersManager).id }) ?? nilFriendRequest) != nilFriendRequest
    }
    
    static func hasFriendRequestFrom(friendRequestsManager: FriendRequestsManager, usersManager: UsersManager, sender: UserModel) -> FriendRequestModel {
        return (friendRequestsManager.requests.first(where: { $0.sender == sender.id && $0.receiver == getUser(usersManager: usersManager).id }) ?? nilFriendRequest)
    }
    
}
