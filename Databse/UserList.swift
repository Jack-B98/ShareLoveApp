//
//  UserList.swift
//  ShareLoveApp
//
//  Created by Yueya Ou on 2/25/20.
//

import Foundation
import Firebase

// Need to delete this class

class UserList {
    
    var user: User?
    
    func toDictionary() -> [String: Any]
    {
        var jsonDictionary = [String:Any]()
        jsonDictionary["user"] = user?.toDictionary()
        return jsonDictionary
    }
    
    init?(snapshot:DataSnapshot)
    {
        let userDictionary = snapshot.value as? [String:Any]
        self.user =  userDictionary?["user"] as? User
    }
    
    init(userToAdd: User)
    {
        self.user = userToAdd
    }
}
