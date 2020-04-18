//
//  EditProfileViewController.swift
//  Capstone Mock
//
//  Created by boob on 3/4/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import Foundation
import UIKit
import Photos
import Firebase
import FirebaseAuth


@available(iOS 13.0, *)
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate {

    @IBOutlet weak var profilePictureImageView: UIImageView!{
        didSet {
            profilePictureImageView.layer.cornerRadius = profilePictureImageView.bounds.width / 2
            profilePictureImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    
     //this is the array to store Fruit entities from the coredata
     
     var changing = false
     var choice = 0
     var index = Int()
     var selectedMeasurement = ""
     let picker = UIImagePickerController()
     var curPic:NSData = NSData()
    
    //var first_name = "", last_name = "", photo_url = ""
    var name: String?, profile_photo: UIImage?
    
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navBar
        // Do any additional setup after loading the view.
        

         //self.firstName.text = first_name
         //self.lastName.text = last_name
         
        print(name ?? "No Name")
        if let userName = name, userName != "Null"
        {
            self.nameTextField.text = userName
        }
        
        if let profilePhoto = profile_photo
        {
            self.profilePictureImageView.image = profilePhoto
        }
    }
    
    func updateProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
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
                     let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                     changeRequest?.photoURL = url
                     
                     changeRequest?.commitChanges { error in
                         if error != nil
                         {
                             print("Error: \(error!.localizedDescription)")
                         }
                     }
                     
                     print("Image URL: \((url?.absoluteString)!)")
                     completion(url)
                 }
             }
         }
     }
    
    @IBAction func saveEdits(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
         let rootReference = Database.database().reference().child("UserList").child((Auth.auth().currentUser?.uid)!)
         /*
         if let new_firstName = self.firstName.text, new_firstName != first_name
         {
             first_name = new_firstName
             print(first_name)
             rootReference.updateChildValues(["firstName":first_name])
         }
         if let new_lastName = self.lastName.text, new_lastName != last_name
         {
             last_name = new_lastName
             print(last_name)
             rootReference.updateChildValues(["lastName":last_name])
         }
          */
        if let new_name = self.nameTextField.text, (new_name != "Name" && new_name != name)
        {
            name = new_name
            print(name!)
            rootReference.updateChildValues(["name":new_name])
        }
        if let new_photo = profilePictureImageView.image, pickPhoto == true
        {
            updateProfileImage(new_photo) { url in
                if let new_url = url
                {
                    self.profile_photo = new_photo
                    rootReference.updateChildValues(["photo":new_url.absoluteString])
                    print("Image URL: \(new_url.absoluteString)")
                }
                else{
                    print ("No Photo URL\n")
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    var pickPhoto: Bool = false
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        // Local variable inserted by Swift 4.2 migrator.
        picker.dismiss(animated: true, completion: nil)
        if self.choice == 0 {
            picker.dismiss(animated: true){
                if let pickedImage = info[.originalImage] as? UIImage {
                    self.photo.image = pickedImage
                    self.pickPhoto = true
                }
            }
            let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
            profilePictureImageView.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        }else {
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            profilePictureImageView.image = image //as? UIImage
        }
        
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        
        print("Clicked")
        let alert = UIAlertController(title: "Select Photo Source", message: nil, preferredStyle: .actionSheet)
        
        
        
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { action in
            self.choice = 0;
            let photoPicker = UIImagePickerController ()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            // display image selection view
            self.present(photoPicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                self.takePicture()
                //selectedPicture.image = picker.
            } else {
                print("No camera")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    func takePicture(){
        self.choice = 1
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
