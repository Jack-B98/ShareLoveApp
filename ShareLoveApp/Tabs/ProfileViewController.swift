//
//  ProfileViewController.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/26/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userFace: UIImageView!{
        didSet {
            userFace.layer.cornerRadius = userFace.bounds.width / 2
            userFace.clipsToBounds = true
        }
    }
    @IBOutlet weak var recieveStatus: UISwitch!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showProfile()
    }
    
    @IBAction func changeRecieveStatus(_ sender: UISwitch) {
        if(sender.isOn == false){
        
        
            let alert = UIAlertController(title: "Are you sure you don't want to recieve some love?", message: "We want to make sure that you are opting out of any chance to recieve money. If you want decide to turn recieving money off, you can turn it back on at any time.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "No, I want to keep recieving money", style: .default, handler: { action in
                sender.setOn(true, animated: true)

            }))
            alert.addAction(UIAlertAction(title: "Yes, I do not want to recieve money", style: .destructive, handler: { action in
    
            }))

            self.present(alert, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getFacebookProfile()
    {
        let requestedFields = "email, first_name, last_name, picture.type(normal)"
        GraphRequest.init(graphPath: "me", parameters: ["fields":requestedFields]).start { (connection, result, error) -> Void in
            guard let result = result as? [String: Any],
                error == nil else {
                    print("Failed to make facebook graph request")
                    return
            }
            
            guard let firstName = result["first_name"] as? String,
                let lastName = result["last_name"] as? String,
                let email = result["email"] as? String,
                let picture = result["picture"] as? [String: Any],
                let data = picture["data"] as? [String: Any],
                let pictureUrl = data["url"] as? String
                else {
                    print("Faield to get email and name from fb result")
                    return
            }
            self.userName.text = firstName + " " + lastName
            let url = URL(string: pictureUrl)
            let url_data = try? Data(contentsOf: url!)
            if let imageData = url_data {
                self.userFace.image = UIImage(data: imageData)
            }
        }
    }
    
    //var first_name = "", last_name = "", photo_url = ""
    func showProfile()
    {
               let googleUser = GIDSignIn.sharedInstance()!.currentUser
               if let user = googleUser
               {
                   let fullName = user.profile.name
                   self.userName.text = fullName
                   let givenName = user.profile.givenName
                   let familyName = user.profile.familyName
                   let email = user.profile.email
                   if user.profile.hasImage
                   {
                       let userDP = user.profile.imageURL(withDimension: 100)
                       let data = try? Data(contentsOf: userDP!)

                       if let imageData = data {
                           self.userFace.image = UIImage(data: imageData)
                       }
                   } else {
                       
                   }
               }
               else if checkFacebookLogInStatus() == true {
                   getFacebookProfile()
               }
               else
               {
                   var user_name: String = "", photo_url: String = ""
                   
                   let destinationReference = Database.database().reference().child("UserList").child((Auth.auth().currentUser?.uid)!)
                   
                   /*
                    var email: String?
                    var firstName: String?
                    var lastName: String?
                    var photo: String?
                    var moneyRecieved: Double?
                    var moneySent: Double?
                    */
                   destinationReference.observe(.value, with: { snapshot in
                       let profile = snapshot.value as? NSDictionary
                       let email = profile?["email"] as? String ?? ""
                       //let firstName = profile?["firstName"] as? String ?? ""
                       //let lastName = profile?["lastName"] as? String ?? ""
                       let name = profile?["name"] as? String ?? ""
                       let moneyRecieved = profile?["moneyRecieved"] as? Double ?? 0.00
                       let moneySent = profile?["moneySent"] as? Double ?? 0.00
                       let photo = profile?["photo"] as? String ?? ""
                       

                       if photo != "No photo"
                       {
                           let photoURL = URL(string: photo)
                           let data = try? Data(contentsOf: photoURL!)

                           if let imageData = data {
                               self.userFace.image = UIImage(data: imageData)
                           }
                       }
        
                       self.userName.text = name
                       //self.photo.setImage(from: photoURL!)
                       //self.email_address.text = email
                       //self.name.text = firstName + " " + lastName
                       //self.money_recieved.text = String(moneyRecieved)
                       //self.money_sent.text = String(moneySent)

                       //self.first_name = firstName
                       //self.last_name = lastName
                   }){ (error) in
                       print(error.localizedDescription)
                   }
               }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditProfileView"{
            print(self.userName.text!)
            if let navController = segue.destination as? UINavigationController
            {
                let toEditProfileViewController: EditProfileViewController = navController.topViewController as! EditProfileViewController
                
                //toEditProfileViewController.first_name = first_name
                //toEditProfileViewController.last_name = last_name
                toEditProfileViewController.name = self.userName.text!
                toEditProfileViewController.profile_photo = self.userFace.image!
            }
        }
    }

    
    @IBAction func returnFromEditProfileView(segue: UIStoryboardSegue)
    {
        if let viewController = segue.source as? EditProfileViewController{
            
            //print(viewController.first_name)
            //print(viewController.last_name)
            //self.name.text = viewController.first_name + " " + viewController.last_name
            self.userFace.image = viewController.profile_photo!
            self.userName.text = viewController.name!
        }
    }
    
    func checkFacebookLogInStatus() -> Bool
    {
        if let token = AccessToken.current, !token.isExpired {
            return true
        }
        return false
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            if checkFacebookLogInStatus() == true {
                LoginManager.init().logOut()
            }
            self.performSegue(withIdentifier: "returnToLoginView", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
}
