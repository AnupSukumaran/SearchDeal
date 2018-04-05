//
//  DetailPageViewController.swift
//  SearchDeal
//
//  Created by Sukumar Anup Sukumaran on 17/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    
    var detailTableVC:DetailViewTableViewController?
    
    
    var SubcatMasterList:SubCatagoryMasterList = SubCatagoryMasterList()
    
    
    
    
    
//    var detailPageTableViewController: DetailViewTableViewController {
//        
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc2 = storyboard.instantiateViewController(withIdentifier: "DetailViewTableViewController") as! DetailViewTableViewController
//        
//        vc2.SubcatMasterList2 = SubcatMasterList
//        
//         self.addViewContAsChildViewController(childViewController: vc2)
//        
//        return vc2
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewTableViewController{
            
            detailTableVC = vc
            
            detailTableVC?.SubcatMasterList2 = SubcatMasterList
            
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if (segue.identifier == "myEmbeddedSegue") {
//            let childViewController = segue.destination as! DetailViewTableViewController
//            
//            childViewController.SubcatMasterList2 = SubcatMasterList
//            // Now you have a pointer to the child view controller.
//            // You can save the reference to it, or pass data to it.
//        }
//    }
    
    
    private func addViewContAsChildViewController(childViewController: UITableViewController){
        
        addChildViewController(childViewController)
        
        view.addSubview(childViewController.view)
        
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        childViewController.didMove(toParentViewController: self)
    }
    
    @IBAction func enquireButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MakeDealViewController") as! MakeDealViewController
        vc.randomid = SubcatMasterList.randomid
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
    }
   
    
    @IBAction func callButton(_ sender: Any) {
        print("NUMBER : ",SubcatMasterList.land)
        if let url = URL(string: "tel://\(SubcatMasterList.land.replacingOccurrences(of: " ", with: ""))") {
            UIApplication.shared.openURL(url)
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
