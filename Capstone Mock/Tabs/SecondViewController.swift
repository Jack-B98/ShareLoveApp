//
//  SecondViewController.swift
//  capstoneProject
//
//  Created by btvaldiv on 2/23/20.
//  Copyright © 2020 btvaldiv. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numbers(_ sender: UIButton) {
        totalLabel.text = totalLabel.text! + String(sender.tag - 1)
        
    }
    @IBAction func backspace(_ sender: UIButton) {
        if(totalLabel.text!.count > 1){
            totalLabel.text?.removeLast()
        }
    }
    
    @IBAction func shareTheLove(_ sender: UIButton) {
        let alert = UIAlertController(title: "Your Love's Been Shared", message: "Thank you so much for sharing the love in the world. Your donation of "+totalLabel.text!+" was recieved by Random Selected User Name Here", preferredStyle: .alert)
        
        
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            
            self.totalLabel.text = "$"
    
            
        }))
        
        
        
        self.present(alert, animated: true)
        
    }
}

