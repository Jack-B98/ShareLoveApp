//
//  ProfileViewController.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/26/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userFace: UIImageView!
    
    @IBOutlet weak var recieveStatus: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
