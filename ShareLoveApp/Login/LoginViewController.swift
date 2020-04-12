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
        checkLogInStatus()
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

                    if errorFound.code == 17011
                    {
                        let alert = UIAlertController(title: "User Not Found", message: errorFound.localizedDescription, preferredStyle: .alert)
                        
                        let createAccountAction = UIAlertAction(title: "Create Account", style: .default) { (action) in
                            
                            self.userEmail.text = ""
                            self.userPassword.text = ""
                            
                            // Option 1: Jump to sign up page
                            self.performSegue(withIdentifier: "createAccount", sender: self)
                            
                            
                            
                            // Option 2: Create an account directly
                            /*
                            self.createAccount(email: self.userEmail.text!, password: self.userPassword.text!)
                            self.userEmail.text = ""
                            self.userPassword.text = ""
                             */
                        }
                        alert.addAction(createAccountAction)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Error", message: errorFound.localizedDescription, preferredStyle: .alert)
 
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                
                    return
                }

                    /*
                    let alert = UIAlertController(title: "Sign In Successfully", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    */
                    self.userEmail.text = ""
                    self.userPassword.text = ""
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
    
    func createAccount(email: String, password: String)
    {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard (authResult?.user) != nil else {
                let errorFound = error! as NSError
                let alert = UIAlertController(title: "Error", message: errorFound.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
        print("Account Created")
        
        let destinationReference = Database.database().reference().child("UserList").child((Auth.auth().currentUser?.uid)!)
           
        //let userProfile = User(email_address: email, first_name: "Null", last_name: "Null", photo: "No photo", money_recieved: 0.00, money_sent: 0.00)
            
        let userProfile = User(email_address: email, name: "Name", photo: "No photo", money_recieved: 0.00, money_sent: 0.00)
        
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
            }
        }
    }
    
    func checkLogInStatus()
    {
        Auth.auth().addStateDidChangeListener { auth, user in
          if let user = user {
            // User is signed in.
            self.performSegue(withIdentifier: "userEntered", sender: self)
          } else {
            // No User is signed in. Show user the login screen
            print("No User is signed in")
          }
        }
    }
    
    @IBAction func returnFromProfileView(segue: UIStoryboardSegue)
    {

    }
    
}
