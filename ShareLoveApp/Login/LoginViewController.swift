//
//  LoginViewController.swift
//  Capstone Mock
//
//  Created by JACK BRYANT on 2/23/20.
//  Copyright © 2020 Jack Bryant. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginErrorMessage: UILabel!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "userEntered")
        {
            
            //moonHop.earthW = Double(self.userWeight.text!)!
        
            
            //let intoApp = segue.destination as! FirstViewController
        }
        
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "userEntered"){
            if(self.userEmail.text!.isEmpty == true ){
                
                self.loginErrorMessage.isHidden = false
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

    @IBAction func logIn(_ sender: UIButton) {
        if (self.userEmail.text!).count > 0 && (self.userPassword.text!).count > 0
            {
                Auth.auth().signIn(withEmail: self.userEmail.text!, password: self.userPassword.text!) { authResult, error in
                
                guard (authResult?.user) != nil else {
                let errorFound = error! as NSError
                let alert = UIAlertController(title: "Error", message: errorFound.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
                    return
                }

                    /*
                    let alert = UIAlertController(title: "Sign In Successfully", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    */
                    
                    self.performSegue(withIdentifier: "userEntered", sender: self)
                }
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "Username and password cannot be empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
    }
    
}
