//
//  SubCatagoryMasterListViewController.swift
//  SearchDeal
//
//  Created by Quiqinfotech on 10/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import MobileCoreServices
import NVActivityIndicatorView

class SubCatagoryMasterListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UIScrollViewDelegate,NVActivityIndicatorViewable{
    
  //  @IBOutlet var viewOptionList: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var buttonOption: UIButton!
    
    
    @IBOutlet weak var buttonSearch: UIButton!

    @IBOutlet weak var buttonLocationSearch: UIButton!
    
    
    @IBOutlet weak var tableSubCatMasterList: UITableView!
    
    @IBOutlet weak var dealsHereView: UIView!
    
    @IBOutlet weak var labelNoResult: UILabel!
    
    @IBOutlet var backButtonWidth: NSLayoutConstraint!
    var SUBCAT_ID = ""
    var Cat_ID = ""
    var page:Int = 0  // 0: normal
                               // 1: nearby search
    
    var limit = "0"
    var limitint = 0
    
    var cat_title = ""
    
    var params = [String:String]()
    var URL:String = ""
    
    var latitude:String = ""
    var longitude:String = ""
    
    
  //  @IBOutlet var viewOption: UIView!
    
    var viewEffects = ViewEffects()
    
    
    var SubCatMasterList = [SubCatagoryMasterList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("CATID = \(Cat_ID)")
        print("SUBID = \(SUBCAT_ID)")
        NSLog("LATI = %@",latitude)
        NSLog("LONG = %@",longitude)
        NSLog("PAGE = %d", page)
        
        
        
       // viewOption.isHidden = true
       // viewEffects.applyPlainShadow(viewOptionList)

        tableSubCatMasterList.delegate=self
        tableSubCatMasterList.dataSource=self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
        if page == 1{
            buttonLocationSearch.isHidden = true
            buttonSearch.isHidden = true
            backButton.setTitle("Nearby "+cat_title+" Search", for: UIControlState())
            backButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
            self.URL = "http://searchdeal.co.in/business-ios/nearsubcategory.php"
            self.params = [
                
                "subid":SUBCAT_ID,
                "lat":self.latitude,
                "long":self.longitude
            ]
      }
        else if page == 0{
          backButton.setTitle(cat_title, for: UIControlState())
            backButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
            self.URL = urlClass().url1 + "subcategoryviewdealcopy.php"
            self.params = [
                "limit":self.limit,
                "lat":self.latitude,
                "long":self.longitude,
                "catid":self.Cat_ID,
                "subid":self.SUBCAT_ID

            ]
           
            
        }

        
        
        backButton.addTarget(self, action: #selector(SubCatagoryMasterListViewController.actionBack(_:)), for: UIControlEvents.touchUpInside)
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( self.URL, method: .get,  parameters:self.params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    self.stopAnimating()
                case .failure(let error):
                    print("ERRRORR = \(error)")
                    self.tableSubCatMasterList.isHidden = true
                    self.labelNoResult.isHidden = false
                    self.stopAnimating()
                    // return userCatagory
                }
        }
      
    }
    
    
    @IBAction func actionBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
        
    
    func jsonResultParse( _ json:AnyObject){
        
        //SubCatMasterList.removeAll()
        
        
        let JSONArray = json as! NSArray
        
        print("JSON COUNT ",JSONArray.count)
        
        if JSONArray.count != 0 {
            
            self.tableSubCatMasterList.isHidden = false
            self.labelNoResult.isHidden = true
            
            for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
                let uCatagory:SubCatagoryMasterList = SubCatagoryMasterList()
                
                uCatagory.category1 = (jObject["category1"] as AnyObject? as? String) ?? ""
                uCatagory.category2 = (jObject["category2"] as AnyObject? as? String) ?? ""
                uCatagory.ccode = (jObject["ccode"] as AnyObject? as? String) ?? ""
                uCatagory.city = (jObject["city"] as AnyObject? as? String) ?? ""
                
                uCatagory.company = (jObject["company"] as AnyObject? as? String) ?? ""
                uCatagory.country = (jObject["country"] as AnyObject? as? String) ?? ""
                uCatagory.dealstatus = (jObject["dealstatus"] as AnyObject? as? String) ?? ""
                uCatagory.description = (jObject["description"] as AnyObject? as? String) ?? ""
                
                
                uCatagory.facility = (jObject["facility"] as AnyObject? as? String) ?? ""
                uCatagory.land = (jObject["land"] as AnyObject? as? String) ?? ""
                uCatagory.mobile = (jObject["mobile"] as AnyObject? as? String) ?? ""
                uCatagory.mobilenumber = (jObject["mobilenumber"] as AnyObject? as? String) ?? ""
                
                uCatagory.name = (jObject["name"] as AnyObject? as? String) ?? ""
                uCatagory.offer = (jObject["offer"] as AnyObject? as? String) ?? ""
                
                uCatagory.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                uCatagory.pin = (jObject["pin"] as AnyObject? as? String) ?? ""
                uCatagory.randomid = (jObject["randomid"] as AnyObject? as? String) ?? ""
                uCatagory.result = (jObject["result"] as AnyObject? as? String) ?? ""
                
                uCatagory.state = (jObject["state"] as AnyObject? as? String) ?? ""
                uCatagory.street = (jObject["street"] as AnyObject? as? String) ?? ""
                uCatagory.ulat = (jObject["ulat"] as AnyObject? as? String) ?? ""
                uCatagory.ulong = (jObject["ulong"] as AnyObject? as? String) ?? ""
                
                
                uCatagory.dealtitle = (jObject["dealtitle"] as AnyObject? as? String) ?? ""
                uCatagory.dealdesc = (jObject["dealdesc"] as AnyObject? as? String) ?? ""
                uCatagory.dealactualprice = (jObject["dealactualprice"] as AnyObject? as? String) ?? ""
                uCatagory.dealdiscountprice = (jObject["dealdiscountprice"] as AnyObject? as? NSNumber) ?? 0
           //     uCatagory.dealofferprice = (jObject["dealofferprice"] as AnyObject? as? NSNumber) ?? 0
                uCatagory.dealvalfrom = (jObject["dealvalfrom"] as AnyObject? as? String) ?? ""
                uCatagory.dealvalto = (jObject["dealvalto"] as AnyObject? as? String) ?? ""
                uCatagory.percentage = (jObject["percentage"] as AnyObject? as? String) ?? ""
                uCatagory.term1 = (jObject["term1"] as AnyObject? as? String) ?? ""
                uCatagory.term2 = (jObject["term2"] as AnyObject? as? String) ?? ""
                uCatagory.term3 = (jObject["term3"] as AnyObject? as? String) ?? ""
                uCatagory.dealphoto = (jObject["dealphoto"] as AnyObject? as? String) ?? ""
                
                uCatagory.cat_id = (jObject["cat_id"] as AnyObject? as? String) ?? ""
                uCatagory.subcat_id = (jObject["subcat_id"] as AnyObject? as? String) ?? ""
                uCatagory.distance = (jObject["distance"] as AnyObject? as? String) ?? ""
                uCatagory.reach = (jObject["reach"] as AnyObject? as? String) ?? ""
                uCatagory.like = (jObject["like"] as AnyObject? as? String) ?? ""
                uCatagory.deal = (jObject["deal"] as AnyObject? as? NSNumber) ?? 0
                uCatagory.user_email = (jObject["user_email"] as AnyObject? as? String) ?? ""
                uCatagory.user_website = (jObject["user_website"] as AnyObject? as? String) ?? ""
                uCatagory.randomid = (jObject["randomid"] as AnyObject? as? String) ?? ""
                SubCatMasterList.append(uCatagory)
                
            }
            
            self.tableSubCatMasterList.reloadData()
            
        }
        else{
        
            self.tableSubCatMasterList.isHidden = true
            self.labelNoResult.isHidden = false
        
        }
        
        
        
        
        
    }
    
    
    
    
    var isNewDataLoading = false
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if !isNewDataLoading{
                
                if (SubCatMasterList.count/10) is Int && self.page == 0{
                
                    self.limitint = limitint+10
                    self.limit = String(limitint)
                    isNewDataLoading = true
                    
                    let parameters = [
                        "category": SUBCAT_ID,
                        "limit": self.limit
                    ]
                    
                    Alamofire.request( urlClass().url1 + "subcategoryviewdealcopy.php", method: .post, parameters: parameters)
                        .validate()
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                print("Validation Successful")
                                self.jsonResultParse(response.result.value! as AnyObject)
                            case .failure(let error):
                                print(error)
                                // return userCatagory
                            }
                    }
                    
                    isNewDataLoading = false
                    self.tableSubCatMasterList.reloadData()

                
                
                }
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        
        return SubCatMasterList.count
    }
    
    var SubcatMaster:SubCatagoryMasterList = SubCatagoryMasterList()

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubCatagoryMasterListTableViewCell
        
        
        
        SubcatMaster = SubCatMasterList[indexPath.row]
        
        let imgurl:String = SubcatMaster.photo.replacingOccurrences(of: " ", with: "%20")
        
        print(imgurl)
        
        cell.imageSubCat.backgroundColor = OSColors.GREY200
        cell.imageSubCat.kf.setImage(with: Foundation.URL(string: imgurl)!,placeholder: nil)
        
        cell.head1.text = SubcatMaster.name
        
        
        cell.head2.text = SubcatMaster.street + ", " + SubcatMaster.city
        //cell.head2.textColor = OSColors.MyColor(SubcatMaster.ccode)
        print("DISTANCE123 = \(SubcatMaster.distance)")
        cell.head3.text = SubcatMaster.distance
        cell.head4.text = SubcatMaster.reach
        cell.head5.text = SubcatMaster.like
        
        let dealsvalue = SubcatMaster.deal
        
        print("Deal NO = \(SubcatMaster.deal)")
        // print("Dealvariable = \(dealsvalue)")
        
        if dealsvalue == 0{
            cell.dealsHereView.isHidden = true
        }else{
            cell.dealsHereView.isHidden = false
        }
        
     //   cell.city.text = SubcatMaster.city
        cell.callButton.tag = indexPath.row
        cell.callButton.addTarget(self, action: #selector(SubCatagoryMasterListViewController.actionCall(_:)), for: UIControlEvents.touchUpInside)
        
//        cell.buttonDetails.tag = indexPath.row
//        cell.buttonDetails.addTarget(self, action: #selector(SubCatagoryMasterListViewController.actionDetails(_:)), for: UIControlEvents.touchUpInside)
        return cell
        
    }
    
    
    func actionCall(_ sender:UIButton){
    
        SubcatMaster = SubCatMasterList[sender.tag]
        
        print("NUMBER : ",self.SubcatMaster.land)
        if let url = Foundation.URL(string: "tel://\(self.SubcatMaster.land.replacingOccurrences(of: " ", with: ""))") {
            UIApplication.shared.openURL(url)
        }
        
        
    
    }
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SubcatMaster = SubCatMasterList[indexPath.row]
        
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc1 = storyboard.instantiateViewController(withIdentifier: "subCatDetailViewController") as! subCatDetailViewController
//        
//        vc1.SubcatMasterList = SubcatMaster
//        
//       // let navController = UINavigationController(rootViewController: vc1)
//        self.present(vc1, animated:true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
        
        vc1.SubcatMasterList = SubcatMaster
       
         self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        
        self.present(vc1, animated:true, completion: self.stopAnimating)

        
        
        

    }
   
//    @IBAction func actionHideOptions(_ sender: AnyObject) {
//       // viewOption.isHidden = true
//    }
//    
//    @IBAction func actionPostBusiness(_ sender: AnyObject) {
//       // viewOption.isHidden = true
//        self.funcWebView("http://searchdeal.co.in/business-profile/business-public",backTitle: "Post Your Business")
//    }
//    
//    
//    @IBAction func actionFaq(_ sender: AnyObject) {
//      //  viewOption.isHidden = true
//        self.funcWebView("http://searchdeal.co.in/business-profile/business-public-faq",backTitle: "FAQ")
//    }
//    
//    @IBAction func actionMerchantLogin(_ sender: AnyObject) {
//       // viewOption.isHidden = true
//        let DB = LocalDB()
//        
//        if DB.getEmail() != "" {
//            self.funcAfterLogin()
//        }
//        else{
//            self.funcLogin()
//        }
//
//    }
//    func funcAfterLogin(){
//        
//        let viewController:UIViewController = UIStoryboard(name: "Main5", bundle: nil).instantiateViewController(withIdentifier: "AddDealViewController") as! AddDealViewController
//        let navController = UINavigationController(rootViewController: viewController)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(viewController, animated: true, completion: nil)
//        
//        
//    }

    
//    @IBAction func actionInviteFriends(_ sender: AnyObject) {
//      //  viewOption.isHidden = true
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//
//        //self.presentViewController(vc, animated: true, completion: nil)
//    }
    
    
//    @IBAction func actionOption(_ sender: AnyObject) {
//       // viewOption.isHidden = false
//        
//    }
    
    
//    @IBAction func actionNearBySearch(_ sender: AnyObject) {
//       
//        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
//        let vc1 = storyboard.instantiateViewController(withIdentifier: "NearBySearchHomeViewController") as! NearBySearchHomeViewController
//        vc1.subcatid=self.SUBCAT_ID
//        vc1.subcatTitla = cat_title
//        vc1.page=1
//        let navController = UINavigationController(rootViewController: vc1)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(vc1, animated: true, completion: nil)
//
//    }
    
    
    
    
    

    
//    @IBAction func actionSearch(_ sender: AnyObject) {
//        
//        let storyboard = UIStoryboard(name: "Main3", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "SEARCH") as! SearchViewController
//        vc.page = 1
//        vc.subcatid = self.SUBCAT_ID
//        self.present(vc, animated: true, completion: nil)
//    
//    }
//    //    self.funcWebView("http://searchdeal.co.in/business-public",backTitle: "Post Your Business")
//    //    self.funcWebView("http://searchdeal.co.in/business-public/business-public-faq",backTitle: "FAQ")
//    func funcWebView( _ url:String, backTitle:String){
//        
//        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
//        vc.backTitle = backTitle
//        vc.LoadURL = url
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(vc, animated: true, completion: nil)
//        
//    }
//
//    
//    func funcLogin(){
//        
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LOGIN") as! MarchantLoginViewController
//        
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(vc, animated: true, completion: nil)
//        
//    }
//    


    
    
    
}
