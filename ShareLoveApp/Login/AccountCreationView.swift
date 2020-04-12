//
//  AccountCreationView.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/23/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountCreationView: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var accountCreationErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "accountCreated")
        {
            
            //moonHop.earthW = Double(self.userWeight.text!)!
        
            
            let intoApp = segue.destination as! FirstViewController
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "accountCreated"){
            if(self.userEmail.text!.isEmpty == true ){
                
                self.accountCreationErrorMessage.isHidden = false
                return false
                
            }
        }
        return true
        
    }
     */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /*
    // If we allow users to set up profile photo when they sign up
     
    // Code
    var photoURL: String?
    @IBAction func SetPhoto(_ sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        }
    }
        
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            picker.dismiss(animated: true){
                if let pickedImage = info[.originalImage] as? UIImage {
                    self.photo.image = pickedImage
                }
            }
        }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child(uid)
        guard let imageData = image.jpegData(compressionQuality: 0.0)
            else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            
            guard metaData != nil else{
                let errorFound = error! as NSError
                let alert = UIAlertController(title: "Error", message: errorFound.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error
                {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                else
                {
                    print("Image URL: \((url?.absoluteString)!)")
                    completion(url)
                }
            }
        }
    }
     */
    
    @IBAction func signUp(_ sender: UIButton) {
        

        guard let email_address = self.userEmail.text, email_address.count > 0 else
               {
                  let alert = UIAlertController(title: "Please enter your email address", message: nil, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                   self.present(alert, animated: true)
                   return
               }
         /*
               guard let first_name = self.firstName.text, first_name.count > 0 else
               {
                  let alert = UIAlertController(title: "Please enter your first name", message: nil, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                   self.present(alert, animated: true)
                   return
               }
               
               guard let last_name = self.lastName.text, last_name.count > 0 else
               {
                  let alert = UIAlertController(title: "Please enter your last name", message: nil, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                   self.present(alert, animated: true)
                   return
               }
               */
               guard let password = self.userPassword.text
                else
               {
                  let alert = UIAlertController(title: "Invalid Password", message: "The password must be 6 characters long or more.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                   self.present(alert, animated: true)
                   return
               }
         /*
               guard let photo = photo.image else {
                   print("No Photo\n")
                   return
               }
        */
               
               Auth.auth().createUser(withEmail: email_address, password: password) { (authResult, error) in
                   guard (authResult?.user) != nil else {
                       let errorFound = error! as NSError
                       let alert = UIAlertController(title: "Error", message: errorFound.localizedDescription, preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                       self.present(alert, animated: true)
                       return
                   }
                   
                /*
                   self.uploadProfileImage(photo) {url in
                       if let photoURL = url
                       {
                           let destinationReference = Database.database().reference().child("UserList").child((Auth.auth().currentUser?.uid)!)
                           
                           print(email_address)
                           print(first_name)
                           print(last_name)

                           let userProfile = User(email_address: email_address, first_name: first_name, last_name: last_name, photo: photoURL.absoluteString, money_recieved: 0.00, money_sent: 0.00)
                           
                           destinationReference.setValue(userProfile.toDictionary())
                       }
                   }
                */
                
                let destinationReference = Database.database().reference().child("UserList").child((Auth.auth().currentUser?.uid)!)
                   
                let userProfile = User(email_address: email_address, name: "Name", photo: "No photo", money_recieved: 0.00, money_sent: 0.00)
                
                destinationReference.setValue(userProfile.toDictionary())
                
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user == nil {
                        // No User is signed in.
                        print("No User is signed in")
                        Auth.auth().signIn(withEmail: self.userEmail.text!, password: self.userPassword.text!) { authResult, error in
                            guard (authResult?.user) != nil else {
                                let errorFound = error! as NSError
                                print(errorFound.localizedDescription)
                                return
                      }
                    }
                  }
                self.userEmail.text = ""
                self.userPassword.text = ""
                self.performSegue(withIdentifier: "accountCreated", sender: self)
                }
        }

    }
    
}
