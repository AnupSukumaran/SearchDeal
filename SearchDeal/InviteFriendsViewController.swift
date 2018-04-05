//
//  InviteFriendsViewController.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 01/08/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Social

class InviteFriendsViewController: UIViewController {
    
    
    @IBOutlet var buttonInvite: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func actionInvite(_ sender: AnyObject) {
        let shareInSocialMedia = UIActivityViewController(activityItems: ["Hey try this new app,it's called search deal. It's finds all the nearby atms, hotels, restaurants , malls, theaters and everything you want based on different  categories, all  within just 3 clicks . It also shows you the best offers near you and anywhere you wish to find in a city. It's really convenient to have this kind of app with us. Try downloading it now http://bit.ly/SearchAnything . You will love it."], applicationActivities: nil)
        self.present(shareInSocialMedia, animated: true, completion: nil)

        
    }

  
}
