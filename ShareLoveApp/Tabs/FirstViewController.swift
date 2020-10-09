//
//  FirstViewController.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/23/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    var socialFeedList:[SocialFeed] = []
    var rootReference = Database.database().reference().child("SocialFeedList")
    
    @IBOutlet weak var socialFeedTable: UITableView!{
        didSet
        {
            socialFeedTable.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpObserverForTable()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(socialFeedList.count)
        return socialFeedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialFeedCell", for: indexPath) as! SocialFeedTableViewCell
        
        cell.layer.borderWidth = 0.00
        
        cell.action.text = socialFeedList[indexPath.row].action
        cell.message.text = socialFeedList[indexPath.row].message
        let photo_url = socialFeedList[indexPath.row].profilePhoto
        if photo_url != "No photo"
        {
            let photoURL = URL(string: photo_url!)
            let data = try? Data(contentsOf: photoURL!)

            if let imageData = data {
                cell.photo.image = UIImage(data: imageData)
            }
        }
        
        print(socialFeedList[indexPath.row].action!)
        print(cell.message.text!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
 
    func setUpObserverForTable()
    {
        let socialFeedRef = Database.database().reference().child("SocialFeedList")
        socialFeedRef.observe(.value, with: { snapshot in
        var newSocialFeedList:[SocialFeed] = []
        print(snapshot.children)
        for socialFeed in snapshot.children {
            print((socialFeed as! DataSnapshot).value ?? "NULL")
            let data = socialFeed as! DataSnapshot
            let dataTemp = data.value as? [String:AnyObject]
            let templist = SocialFeed()
            templist.action = dataTemp?["action"] as! String
            templist.message = dataTemp?["message"] as! String
            templist.profilePhoto = dataTemp?["profilePhoto"] as! String
            
            newSocialFeedList.append(templist as! SocialFeed)
        }
        self.socialFeedList = newSocialFeedList
        self.socialFeedTable.reloadData()
            
        })
    }

}

