//
//  NearBySearchFromHomeViewController.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 06/08/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import Kingfisher
import CoreLocation

class NearBySearchFromHomeViewController: UIViewController,NVActivityIndicatorViewable,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet var buttonBack: UIButton!
    
   // @IBOutlet var buttonOption: UIButton!
    
    @IBOutlet var tableNearBySearchHome: UITableView!
    
   // @IBOutlet var buttonHideOption: UIButton!
    
    @IBOutlet var viewOption: UIView!
    
    @IBOutlet weak var buttonSearch: UIButton!
   
    @IBOutlet var subViewOption: UIView!
    
    //var SUBCAT_ID = ""
    //var page:Int = 0
    
    let locationManager = CLLocationManager()
    
    
    let vieweffects = ViewEffects()
    var nearByCatagory = [NearBySearchCatagory]()
    
    var SubCatMasterList = [SubCatagoryMasterList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
       // vieweffects.applyPlainShadow(subViewOption)
        
        tableNearBySearchHome.delegate=self
        tableNearBySearchHome.dataSource=self
        buttonBack.setTitle("Search Nearby", for: UIControlState())
        buttonBack.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url2 + "usercategorylist.php", method: .get, parameters: ["": ""])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    self.stopAnimating()
                case .failure(let error):
                    print(error)
                    self.stopAnimating()
                    // return userCatagory
                }
                
                
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func jsonResultParse( _ json:AnyObject){
        
        nearByCatagory.removeAll()
        let JSONArray = json as! NSArray
        if JSONArray.count != 0 {
            
            for i:Int in 0 ..< JSONArray.count  {
                let jObject = JSONArray[i] as! NSDictionary
                let uCatagory:NearBySearchCatagory = NearBySearchCatagory()
                uCatagory.id = (jObject["id"] as AnyObject? as? String) ?? ""
                uCatagory.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                uCatagory.type = (jObject["type"] as AnyObject? as? String) ?? ""
                uCatagory.radius = (jObject["radius"] as AnyObject? as? String) ?? ""
                uCatagory.name = (jObject["name"] as AnyObject? as? String) ?? ""
                uCatagory.result = (jObject["result"] as AnyObject? as? String) ?? ""
                nearByCatagory.append(uCatagory)
            }
            self.tableNearBySearchHome.reloadData()
        }
        
        
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return nearByCatagory.count/2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomePageTableViewCell
        
        
        let check:Int = indexPath.row*2
        if nearByCatagory.count > check{
            cell.labelName1.text = nearByCatagory[check].name
           
            cell.button1.tag = check
            
            cell.leftCellView.layer.masksToBounds = false
            
            cell.leftCellView.layer.shadowColor = UIColor.black.cgColor
            cell.leftCellView.layer.shadowOpacity = 0.5
            cell.leftCellView.layer.shadowOffset = CGSize.zero
            cell.leftCellView.layer.shadowRadius = 1
            
        
            cell.rightCellView.layer.masksToBounds = false
            
            cell.rightCellView.layer.shadowColor = UIColor.black.cgColor
            cell.rightCellView.layer.shadowOpacity = 0.5
            cell.rightCellView.layer.shadowOffset = CGSize.zero
            cell.rightCellView.layer.shadowRadius = 1
            
            
            
            
           
            let imgUrl = URL(string: nearByCatagory[check].photo)
           
            
            cell.image1.kf.setImage(with: imgUrl!,placeholder: nil)
            if nearByCatagory.count > check+1{
                
                cell.labelName2.text = nearByCatagory[check+1].name
              
                cell.button2.tag = check+1
                
                let imgUrl1 = URL(string: nearByCatagory[check+1].photo)
                cell.image2.kf.setImage(with: imgUrl1!,placeholder: nil)
            }
            
        }
        
        cell.button1.addTarget(self, action: #selector(HomePageViewController.actionButton1(_:)), for: UIControlEvents.touchUpInside)
        cell.button2.addTarget(self, action: #selector(HomePageViewController.actionButton2(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        
        print("INDEX PATH ROW ",check)
        
        return cell
    }
    
    
    @IBAction func actionSearch(_ sender: AnyObject) {
        
        self.funcSearch(nearByCatagory[sender.tag].name)
        
            }
    
    func funcSearch(_ name:String)
    {
        
        let storyboard = UIStoryboard(name: "Main3", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SEARCH2") as! SearchViewController2
      //  vc.page = 0
        //vc.subcatid = self.SUBCAT_ID
        vc.nameTitle = name
        self.present(vc, animated: true, completion: nil)

        
    }

    
    func actionButton1(_ sender:UIButton)
    {
        
        
        if CLLocationManager.authorizationStatus() == .denied{
            
            let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }))
            
            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alertControllerz, animated: true, completion: nil)
        }
            
        else{
            
            // self.locationManager.startUpdatingLocation()
            print("LATITUDE : ",self.latitude)
            print("LONGITUDE : ",self.longitude)
            //let currentLocation = self.latitude+","+self.longitude
            if self.latitude == "" || self.longitude  == "" {
                let alert = UIAlertView(title: OSConstants.APPLICATION_NAME(), message: "Location not found", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
                
            else{
                self.funcSubcatagory(nearByCatagory[sender.tag].radius,typ: nearByCatagory[sender.tag].type,nam: nearByCatagory[sender.tag].name)
            }
        }
        
        
    }
    
    
    func actionButton2(_ sender:UIButton)
    {
        
        if CLLocationManager.authorizationStatus() == .denied{
            
            let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }))
            
            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alertControllerz, animated: true, completion: nil)
        }
            
        else{
            
            self.locationManager.startUpdatingLocation()
            print("LATITUDE : ",self.latitude)
            print("LONGITUDE : ",self.longitude)
           // let currentLocation = self.latitude+","+self.longitude
            if self.latitude == "" || self.longitude  == "" {
                let alert = UIAlertView(title: OSConstants.APPLICATION_NAME(), message: "Location not found", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
                
            else{
                self.funcSubcatagory(nearByCatagory[sender.tag].radius,typ: nearByCatagory[sender.tag].type,nam: nearByCatagory[sender.tag].name)
            }
        }
        
        
    }
    
    func funcSubcatagory(_ rad:String,typ:String,nam:String)
    {
        let storyboard = UIStoryboard(name: "Main3", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "NearBySearchCatagoryListViewController") as! NearBySearchCatagoryListViewController
        vc1.radius = rad
        vc1.type = typ
        vc1.name = nam
        vc1.latitude = self.latitude
        vc1.longitude = self.longitude
        
        let navController = UINavigationController(rootViewController: vc1)
        self.present(navController, animated:true, completion: nil)
        
      //  self.presentViewController(vc1, animated: true, completion: nil)
    }
    
    
    
    
    var latitude:String = ""
    var longitude:String = ""
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        let lati :NSNumber = NSNumber(value:(newLocation?.coordinate.latitude)!)
        let longi :NSNumber  = NSNumber(value:(newLocation?.coordinate.longitude)!)
        self.latitude = String(describing: lati)
        self.longitude = String(describing: longi)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    @IBAction func actionPostBusiness(_ sender: AnyObject) {
//        
//        self.viewOption.isHidden=true
//        self.funcWebView("http://searchdeal.co.in/business-profile/business-public",backTitle: "Post Your Business")
//    }
    
//    @IBAction func actionFAQ(_ sender: AnyObject) {
//
//        self.viewOption.isHidden=true
//        self.funcWebView("http://searchdeal.co.in/business-profile/business-public-faq",backTitle: "FAQ")
//    }
    
//    @IBAction func actionLogin(_ sender: AnyObject) {
//
//        self.viewOption.isHidden=true
//
//        let DB = LocalDB()
//
//        if DB.getEmail() != "" {
//            self.funcAfterLogin()
//        }
//        else{
//            self.funcLogin()
//        }
//    }
    
//    @IBAction func actionInviteFriends(_ sender: AnyObject) {
//        self.viewOption.isHidden=true
//        self.funcInviteFriends()
//    }
    
    
//    func funcInviteFriends(){
//
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//
//       // self.presentViewController(vc, animated: true, completion: nil)
//
//
//    }
//
//    func funcLogin(){
//
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LOGIN") as! MarchantLoginViewController
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(vc, animated: true, completion: nil)
//
//    }
//
//
//
//    func funcWebView( _ url:String, backTitle:String){
//
//        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
//        vc.backTitle = backTitle
//        vc.LoadURL = url
//
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(vc, animated: true, completion: nil)
//
//    }
//
//
    
    
    
}
