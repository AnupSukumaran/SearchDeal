//
//  MerchantMainViewController.swift
//  SearchDeal
//
//  Created by Sukumar Anup Sukumaran on 31/08/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import XLPagerTabStrip




class MerchantMainViewController: ButtonBarPagerTabStripViewController {
    
    let blueInstagramColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "PhoneNum") == nil{
            print("Data Not Present")
        }else{
            print("Data Present")
            let new = UserDefaults.standard.object(forKey: "PhoneNum") as? String
            
            print("NEW123 = \(new ?? "NOT")")
        }
        
        super.viewDidLoad()
    }

    override func viewDidLoad() {
       // super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Poppins-Regular", size: 20)!]

        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .red
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 12)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
        super.viewDidLoad()
        
       
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
        
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        print("WORKING!!??")
        
        if UserDefaults.standard.object(forKey: "PhoneNum") == nil{
            let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyBusiness")
            
            let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyDeals")
            
            let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Analytics")
            
            return [child_1, child_2, child_3]
            
        }else{
            let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BussinesProfileViewController")
            
            let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyDeals")
            
            let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Analytics")
            
            return [child_1, child_2, child_3]
        }
        
     
       
    }


}
