//
//  SocialFeedList.swift
//  ShareLoveApp
//
//  Created by Yueya Ou on 4/5/20.
//

import Foundation
import Firebase

class SocialFeedList
{
    var socialFeedList: [SocialFeed]?
    
    func toDictionary() -> [String: Any]
    {
        var jsonDictionary = [String: Any]()
        if let list = socialFeedList
        {
            var dictionaryElements = [[String: Any]]()
            for socialFeed in list
            {
                dictionaryElements.append(socialFeed.toDictionary())
            }
            jsonDictionary["socialFeedList"] = dictionaryElements
        }
        return jsonDictionary
    }
    
    init?(snapshot:DataSnapshot)
    {
        self.socialFeedList(snapshot: snapshot.childSnapshot(forPath: "socialFeedList"))
    }
    
    init(socialFeedToAdd: SocialFeed)
    {
        self.socialFeedList?.append(socialFeedToAdd)
    }
    
    func socialFeedList(snapshot: DataSnapshot) {
        for element in snapshot.children {
            guard let socialFeed = element as? DataSnapshot else { continue }
        }
    }
    
    func getSocialFeed(item:Int) -> SocialFeed{
        
        return self.socialFeedList![item]
    }
}
