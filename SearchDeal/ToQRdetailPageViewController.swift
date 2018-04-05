//
//  ToQRdetailPageViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 21/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit

class ToQRdetailPageViewController: UIViewController,DataIndicationDelegate {
   
    func DataIndicate(value: Bool) {
        dataIndicate = value
        NoDataView.isHidden = value
    }
    
    var dataIndicate:Bool = true
    
    // var QRdetailTableVC:ToQRdetailTableViewController?
    @IBOutlet weak var NoDataView: UIView!
    
    var qrcode = ""
    
    var locations:locationMode = locationMode()
    
    var SubcatMasterList:SubCatagoryMasterList = SubCatagoryMasterList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NoDataView.isHidden = false
        
      print("ORCODE1 = \(qrcode)")
        print("LATO1 = \(locations.latitude)")
        print("LONGGO1 = \(locations.longitude)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        print("working many time here??!!!")
        
        if let vc = segue.destination as? ToQRdetailTableViewController{

            vc.qrcode = qrcode
            vc.locations = locations
            vc.delegate = self
           

        }
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
    
    

    @IBAction func backAction(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        // self.performSegue(withIdentifier: "unwindToHome2", sender: self)
    }
}




//@IBAction func enquireButton(_ sender: Any) {
//    
//    let storyboard = UIStoryboard(name: "Main4", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "MakeDealViewController") as! MakeDealViewController
//    vc.randomid = SubcatMasterList.randomid
//    let navController = UINavigationController(rootViewController: vc)
//    self.present(navController, animated:true, completion: nil)
//}
//
//@IBAction func callButton(_ sender: Any) {
//    print("NUMBER : ",SubcatMasterList.land)
//    if let url = URL(string: "tel://\(SubcatMasterList.land.replacingOccurrences(of: " ", with: ""))") {
//        UIApplication.shared.openURL(url)
//    }
//    
//}
