//
//  AccountCreationView.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/23/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit

class AccountCreationView: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var accountCreationErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        var shouldCreate:Bool = false;
        if (identifier == "accountCreated")
        {
            if (self.userEmail.text!.isEmpty == true || self.userPassword.text!.isEmpty == true)
            {
                self.accountCreationErrorMessage.isHidden = false
            }
            else
            {
                shouldCreate = true
            }
        }
        
        return shouldCreate
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
