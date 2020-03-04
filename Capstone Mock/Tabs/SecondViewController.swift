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
    
    var currentAmount = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numbers(_ sender: UIButton) {
        currentAmount = Double((currentAmount*10) + (Double(sender.tag-1) * 0.01))
        currentAmount = Double(round(100*currentAmount)/100)
        print(currentAmount)
        //var indy = String(currentAmount).firstIndex(of: ".")!
        //indy.
        //String(currentAmount).prefix(through:  Index(2)+ String(currentAmount).firstIndex(of: ".")!, index)
        totalLabel.text = "$ " + String(currentAmount) //String(currentAmount).prefix(upTo: Index(2)+String(currentAmount).firstIndex(of: ".")!)
        
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
        let alert = UIAlertController(title: "Your Love's Been Shared", message: "Thank you so much for sharing the love in the world. Your donation of "+totalLabel.text!+" was recieved by Random Selected User Name Here", preferredStyle: .alert)
        
        
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            
            self.totalLabel.text = "$ 0.00"
    
            
        }))
        
        
        
        self.present(alert, animated: true)
        
    }
}

