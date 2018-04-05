//
//  SuccessPageViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 10/10/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit

class SuccessPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    
    @IBAction func CloseButton(_ sender: Any) {
        
        print("working!!")
        //self.presentedViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
}
