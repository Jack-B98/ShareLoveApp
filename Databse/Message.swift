//
//  Message.swift
//  ShareLoveApp
//
//  Created by Yueya Ou on 3/9/20.
//

import Foundation
import Firebase

class Message {
    var name: String?
    var amount: Double?
    var content: String?
    var recievedOrSent: String?
    
    init(user: User, amount: Double, recievedOrSent: String, content: String)
    {
        guard let firstName = user.firstName, let lastName = user.lastName
        else{
            print("No User Name")
            return
        }
        self.name = firstName + " " + lastName
        self.amount = amount
        self.recievedOrSent = recievedOrSent
        self.content = content
    }
}
