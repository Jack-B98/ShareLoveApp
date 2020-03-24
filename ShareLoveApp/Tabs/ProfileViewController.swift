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

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userFace: UIImageView!
    
    @IBOutlet weak var recieveStatus: UISwitch!
    
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

    var first_name = "", last_name = "", photo_url = ""
    
    func showProfile()
    {
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
        print(snapshot.children)
            let profile = snapshot.value as? NSDictionary
            let email = profile?["email"] as? String ?? ""
            let firstName = profile?["firstName"] as? String ?? ""
            let lastName = profile?["lastName"] as? String ?? ""
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
            print(photo)
            //self.photo.setImage(from: photoURL!)
            //self.email_address.text = email
            //self.name.text = firstName + " " + lastName
            //self.money_recieved.text = String(moneyRecieved)
            //self.money_sent.text = String(moneySent)

            self.first_name = firstName
            self.last_name = lastName
            self.photo_url = photo
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditProfileView"{
            if let toEditProfileViewController: EditProfileViewController = segue.destination as? EditProfileViewController {
                
                toEditProfileViewController.first_name = first_name
                toEditProfileViewController.last_name = last_name
                toEditProfileViewController.photo_url = photo_url
            }
        }
    }

    
    @IBAction func returnFromEditProfileView(segue: UIStoryboardSegue)
    {
        if let viewController = segue.source as? EditProfileViewController{
            
            print(viewController.first_name)
            print(viewController.last_name)
            //self.name.text = viewController.first_name + " " + viewController.last_name
            
            print(viewController.photo_url)
            let photoURL = URL(string: viewController.photo_url)
            let data = try? Data(contentsOf: photoURL!)

            if let imageData = data {
                self.userFace.image = UIImage(data: imageData)
            }
        }
    }
}
