//
//  Analytics.swift
//  SearchDeal
//
//  Created by Sukumar Anup Sukumaran on 31/08/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import NVActivityIndicatorView

class Analytics: UIViewController, IndicatorInfoProvider, NVActivityIndicatorViewable {

    
    let mobno = UserDefaults.standard.object(forKey: "PhoneBeforeSubmit") as? String
    var likesCount:Int = 0
    var reachCount:Int = 0
    var DealCount: String = ""
    var EnquityCount:Int = 0
    var TotalCount:Int = 0
    
    @IBOutlet weak var reachesLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var enquiryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "user_analytic.php", method: .get,  parameters:["mobno":mobno!])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    self.stopAnimating()
                case .failure(let error):
                    print("ERRRORR = \(error)")
                    self.stopAnimating()
                    // return userCatagory
                }
        }

        
    }
    
    func jsonResultParse( _ json:AnyObject){
        
            let JSONArray = json as! NSArray
        
        print("JSON Count =", JSONArray.count)
        
        if JSONArray.count != 0 {
            
            for i:Int in 0 ..< JSONArray.count  {
                let jObject = JSONArray[i] as! NSDictionary
                
                likesCount = jObject.value(forKey: "like") as! Int
                reachCount = jObject.value(forKey: "reach") as! Int
                DealCount = jObject.value(forKey: "deal") as! String
                EnquityCount = jObject.value(forKey: "enquiry") as! Int
                TotalCount = jObject.value(forKey: "total") as! Int
                
                if reachCount != 1 {
                    reachesLabel.text =    String(reachCount) + " Reaches"
                }else{
                     reachesLabel.text =    String(reachCount) + " Reach"
                }
                
                if likesCount != 1 {
                    likesLabel.text =      String(likesCount) + " Likes"
                }else{
                    likesLabel.text =      String(likesCount) + " Like"
                }
                
                if DealCount != "1 Deals"{
                    dealsLabel.text = DealCount
                }else{
                    print("DealsCount123 =", DealCount)
                   //  DealCount.remove(at: DealCount.endIndex)
                    DealCount = String(DealCount.characters.dropLast())
                    print("DealsCount456 =", DealCount)
                    dealsLabel.text = DealCount
                    
                }
                
                if EnquityCount != 1 {
                    enquiryLabel.text = String(EnquityCount) + " Enquiries"
                }else{
                    enquiryLabel.text = String(EnquityCount) + " Enquiry"
                }
         
                
            }
        }
        
            
        }
        
        
    //MARK: Func to give the title Name of the top scroll tab
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Analytics")
    }
    


}
