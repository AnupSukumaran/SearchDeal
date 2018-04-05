//
//  MyDeals.swift
//  SearchDeal
//
//  Created by Sukumar Anup Sukumaran on 31/08/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyDeals: UIViewController, IndicatorInfoProvider {
    
    
//    var itemInfo: IndicatorInfo = "View"
//    
//    init(itemInfo: IndicatorInfo) {
//        self.itemInfo = itemInfo
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
    //}

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MyDeals")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ToDealForm(_ sender: Any) {
        
        let alert = UIAlertController(title: "Coming Soon", message: "Under development", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
