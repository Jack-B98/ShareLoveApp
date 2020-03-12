//
//  LoginViewController.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/23/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginErrorMessage: UILabel!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        var shouldGo:Bool = false
        if (identifier == "userEntered")
        {
            if (self.userEmail.text!.isEmpty == true || self.userPassword.text!.isEmpty == true)
            {
                self.loginErrorMessage.isHidden = false
            }
            else
            {
                shouldGo = true;
            }
        }
        
        if (identifier == "newUser")
        {
            shouldGo = true
        }
        
        return shouldGo
        
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
