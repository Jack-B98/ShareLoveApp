//
//  EditProfileViewController.swift
//  Capstone Mock
//
//  Created by boob on 3/4/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    
    
    
     //this is the array to store Fruit entities from the coredata
     
     var changing = false
     var choice = 0
     var index = Int()
     var selectedMeasurement = ""
     let picker = UIImagePickerController()
     var curPic:NSData = NSData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        // Local variable inserted by Swift 4.2 migrator.
        picker.dismiss(animated: true, completion: nil)
        if self.choice == 0 {
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
