//
//  User.swift
//  ShareLoveApp
//
//

// Convert JSON to Swift classes for storing user infomation

import Foundation
import Firebase

class User {
    var email: String?
    //var firstName: String?
    //var lastName: String?
    var name: String?
    var photo: String?
    var moneyRecieved: Double?
    var moneySent: Double?
    
    var rootRef: DatabaseReference = Database.database().reference()
    
    func toDictionary() ->[String:Any] {
        var jsonDictionary = [String:Any]()
        jsonDictionary["email"] = email
        //jsonDictionary["firstName"] = firstName
        //jsonDictionary["lastName"] = lastName
        jsonDictionary["name"] = name
        jsonDictionary["photo"] = photo
        jsonDictionary["moneyRecieved"] = moneyRecieved
        jsonDictionary["moneySent"] = moneySent
        
        return jsonDictionary
    }
    
    init?(snapshot: DataSnapshot) {
        let userDictionary = snapshot.value as? [String:Any]
        
        self.email = userDictionary?["email"] as? String
        //self.firstName = userDictionary?["firstName"] as? String
        //self.lastName = userDictionary?["lastName"] as? String
        self.name = userDictionary?["name"] as? String
        self.photo = userDictionary?["photo"] as? String
        self.moneyRecieved = userDictionary?["moneyRecieved"] as? Double
        self.moneySent = userDictionary?["moneySent"] as? Double
    }
    
    /*
    init(email_address: String, first_name: String, last_name: String, photo: String, money_recieved: Double, money_sent: Double)
    {
        self.email = email_address
        self.firstName = first_name
        self.lastName = last_name
        self.photo = photo
        self.moneyRecieved = money_recieved
        self.moneySent = money_sent
    }
    */
    init(email_address: String, name: String, photo: String, money_recieved: Double, money_sent: Double)
    {
        self.email = email_address
        self.name = name
        self.photo = photo
        self.moneyRecieved = money_recieved
        self.moneySent = money_sent
    }
    
    
    
    /*
    func addUserProfile(userProfile: User)
    {
        let destinationReference = rootRef.child("UserList").child((Auth.auth().currentUser?.uid)!)
        destinationReference.setValue(userProfile)
    }
    */
    
    func updateUserProfile(userProfile: User)
    {
        let destinationReference = rootRef.child("UserList").child((Auth.auth().currentUser?.uid)!)
        destinationReference.setValue(userProfile.toDictionary())
    }
    
    func getUserProfile() -> User?
    {
        var thisUser: User?
        let thisUserReference = rootRef.child("UserList").child((Auth.auth().currentUser?.uid)!)
        thisUserReference.observe(.value, with: { snapshot in
            if snapshot.exists()
            {
                thisUser = User(snapshot: snapshot)
            }
        })
        
        return thisUser
    }
}
