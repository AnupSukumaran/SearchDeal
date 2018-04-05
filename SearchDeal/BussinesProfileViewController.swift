//
//  BussinesProfileViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 12/10/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import Kingfisher
import NVActivityIndicatorView

class BussinesProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, IndicatorInfoProvider, NVActivityIndicatorViewable {
    
   
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var businessProfilesTable: UITableView!
    
   
   var businessData = [BusinessProfileModel]()
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MyBusiness")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.businessProfilesTable.reloadData()
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let mobno = UserDefaults.standard.object(forKey: "PhoneBeforeSubmit")
       
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "list_business.php", method: .get,  parameters:["mobno":mobno!])
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
                    
                }
        }
        

       
    }
            
    func jsonResultParse( _ json:AnyObject){
        
        businessData.removeAll()
        
        let JSONArray = json as! NSArray
        
         if JSONArray.count != 0 {
            
             for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
                let uBusinessProfileData:BusinessProfileModel = BusinessProfileModel()
                
                uBusinessProfileData.u_id = (jObject["id"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.cat_id = (jObject["cat_id"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.subcat_id = (jObject["subcat_id"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.category = (jObject["category"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.sub_category = (jObject["sub_category"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.title = (jObject["title"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.description = (jObject["description"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.user_mobile = (jObject["user_mobile"] as AnyObject? as? String) ?? ""
                    
                uBusinessProfileData.user_email = (jObject["user_email"] as AnyObject? as? String) ?? ""
                    
                uBusinessProfileData.user_website = (jObject["user_website"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.door_no = (jObject["door_no"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.street = (jObject["street"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.city = (jObject["city"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.state = (jObject["state"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.pincode = (jObject["pincode"] as AnyObject? as? String) ?? ""
                    
                    
                uBusinessProfileData.latitude = (jObject["latitude"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.longitude = (jObject["longitude"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.opens_at = (jObject["opens_at"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.closed_at = (jObject["closed_at"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.business_promocode = (jObject["business_promocode"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.qr_code = (jObject["qr_code"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.result = (jObject["result"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.created_at = (jObject["created_at"] as AnyObject? as? String) ?? ""
                
                uBusinessProfileData.terms1 = (jObject["terms1"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.terms2 = (jObject["terms2"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.terms3 = (jObject["terms3"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.status = (jObject["status"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.user_plan = (jObject["user_plan"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                uBusinessProfileData.uuid = (jObject["uuid"] as AnyObject? as? String) ?? ""
                
                businessData.append(uBusinessProfileData)
                
            }
            
            self.businessProfilesTable.reloadData()
            
        }
            
            
    }
    
    //MARK: Funcs to displaey Data to Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BussinesProfilesTableViewCell", for: indexPath) as! BussinesProfilesTableViewCell
        
        let imgUrl = URL(string: self.businessData[indexPath.row].photo)

        print("IMGAUrl12341234 = \(String(describing: imgUrl))")
        cell.businessImage.kf.indicatorType = .activity
        cell.businessImage.kf.setImage(with: imgUrl!, placeholder: nil, options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
//        DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
//            print("Hit3")
//
//            DispatchQueue.main.async {
//                print("Hit4")
//                (cell.businessImage.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
//                cell.businessImage.kf.indicator?.startAnimatingView()
//                if let imageData = imgUrl{
//                    print("Hit5")
//                    cell.businessImage.kf.indicator?.stopAnimatingView()
//                cell.businessImage.kf.setImage(with: imageData)
//                }
//            }
//        }
        
        cell.BusinessTitle.text = businessData[indexPath.row].title
        cell.addressLabel.text = businessData[indexPath.row].street + ", " + businessData[indexPath.row].city
        cell.categoryLabel.text = businessData[indexPath.row].category
        cell.subCategory.text = businessData[indexPath.row].sub_category
        cell.profileStatus.text = "(" + businessData[indexPath.row].status + ")"
        
        cell.ProfileEditButton.addTarget(self, action: #selector(actionButton(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }

    func actionButton(_ sender:UIButton)
    {
        //self.businessProfilesTable.reloadData()
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditBusinessViewController") as! EditBusinessViewController

        vc.businessDetails = businessData[sender.tag]

        self.present(vc, animated: true, completion: nil)
    }
    
    

  

}


