//
//  SocialFeed.swift
//  ShareLoveApp
//
//  Created by Yueya Ou on 4/5/20.
//

import Foundation
import Firebase

class SocialFeed
{
    var action: String?
    var message: String?
    var profilePhoto: String?
    
    func toDictionary() ->[String:Any] {
         var jsonDictionary = [String:Any]()

        jsonDictionary["action"] = action
        jsonDictionary["message"] = message
        jsonDictionary["profilePhoto"] = profilePhoto
         
         return jsonDictionary
     }
     
     init?(snapshot: DataSnapshot) {
         let socialfeedDictionary = snapshot.value as? [String:Any]
         
        self.action = socialfeedDictionary?["action"] as? String
        self.message = socialfeedDictionary?["message"] as? String
        self.profilePhoto = socialfeedDictionary?["profilePhoto"] as? String
     }
     
    init(action: String, message: String, photo: String)
    {
        self.action = action
        self.message = message
        self.profilePhoto = photo
    }
    
    init()
    {
        self.action = ""
        self.message = ""
        self.profilePhoto = ""
    }
    
}
