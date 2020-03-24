//
//  SecondViewController.swift
//  capstoneProject
//
//  Created by btvaldiv on 2/23/20.
//  Copyright © 2020 btvaldiv. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var senderMessage: UITextView!
    
    var currentAmount = 0.00
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderMessage.delegate = self
        
        
       
    }
    
    
    // Hides the keyboard when the return key is pressed.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    // Hides the keyboard if anywhere else in the View Controller is touched that is not a button.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    
    @IBAction func numbers(_ sender: UIButton) {
        view.endEditing(true) // Hides keyboard if keyboard is appearing when button is pressed
        
        currentAmount = Double((currentAmount*10) + (Double(sender.tag-1) * 0.01))
        currentAmount = Double(round(100*currentAmount)/100)
        print(currentAmount)
        
        totalLabel.text = "$ " + String(currentAmount)
        
    }
    @IBAction func backspace(_ sender: UIButton) {
        currentAmount = Double(currentAmount/10)
        currentAmount = Double(round(100*currentAmount)/100)
        print(currentAmount)
        if(currentAmount == 0.0){
            totalLabel.text = "$ 0.00"
        } else{
            totalLabel.text = "$ " + String(currentAmount)
        
            
        }
    }
    
    
    
    
    @IBAction func shareTheLove(_ sender: UIButton) {
        let confirmation = UIAlertController(title: "Are you sure?", message: "Are you sure that you want to send out "+totalLabel.text!, preferredStyle: .alert)
        
        confirmation.addAction(UIAlertAction(title: "Yes, I want to share the love", style: .default, handler: { action in
            
            
            let alert = UIAlertController(title: "Your Love's Been Shared", message: "Thank you so much for sharing the love in the world. Your donation of \n"+self.totalLabel.text!+" was recieved by Random Selected User Name Here", preferredStyle: .alert)
                
                
                
                
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    self.senderMessage.text = ""
                    self.totalLabel.text = "$ 0.00"
            
                    
                }))
                
                
                
                self.present(alert, animated: true)
        }))
        
        confirmation.addAction(UIAlertAction(title: "No, I didn't mean to hit send", style: .destructive, handler: { action in
            
        }))
        
        self.present(confirmation, animated: true)
    }
}

