//
//  NearBySearchCatagoryListViewController.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 06/08/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import NVActivityIndicatorView
import Kingfisher

class NearBySearchCatagoryListViewController: UIViewController,CLLocationManagerDelegate,NVActivityIndicatorViewable ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var buttonBack: UIButton!
    
  //  @IBOutlet var buttonOption: UIButton!
    
    @IBOutlet var tableNearCatList: UITableView!
    
    @IBOutlet var viewNoResultsFound: UIView!
    
    @IBOutlet var viewOption: UIView!
    
   // @IBOutlet var subViewOption: UIView!
    
    let vieweffects = ViewEffects()
    let locationManager = CLLocationManager()
    var latitude:String = ""
    var longitude:String = ""
    var radius:String=""
    var type:String=""
    var name:String=""
    
    var currentLocation : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        buttonBack.setTitle("Nearby "+name, for: UIControlState())
        buttonBack.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
        viewNoResultsFound.isHidden = true
        tableNearCatList.isHidden=false
        tableNearCatList.dataSource=self
        tableNearCatList.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
        //        locationManager.delegate = self
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //
        //        self.locationManager.startUpdatingLocation()
        
        
        
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
            let currentLocation = self.latitude+","+self.longitude
            
            
            
            if self.latitude == "" || self.longitude  == "" {
                
                let alert = UIAlertView(title: OSConstants.APPLICATION_NAME(), message: "Location not found", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            else{
                
                let params = [
                    
                    "location":currentLocation,
                    "radius":self.radius,
                    "type":self.type,
                    "sensor":"true",
                    "key":"AIzaSyBJPh21q86pmaelvv9dQGc6uwL5J-QmDqQ"
                ]
                
                self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
                Alamofire.request("https://maps.googleapis.com/maps/api/place/search/json", method: .get, parameters:params)
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            print("Validation Successful")
                            self.jsonResultParse(response.result.value! as AnyObject)
                        // self.stopActivityAnimating()
                        case .failure(let error):
                  
                            print(error)
                            self.viewNoResultsFound.isHidden = false
                            self.tableNearCatList.isHidden=true
                            self.stopAnimating()
                            
                        }
                }
            }
        }
       
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        let lati :NSNumber = NSNumber(value:(newLocation?.coordinate.latitude)!)
        let longi :NSNumber  = NSNumber(value:(newLocation?.coordinate.longitude)!)
        self.latitude = String(describing: lati)
        self.longitude = String(describing: longi)
        self.locationManager.stopUpdatingLocation()
        
    }
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    var googleResults = [GoogleResults]()
    var locations = ""
    func jsonResultParse( _ json:AnyObject){
        googleResults.removeAll()
        locations=""
        if json is NSDictionary{
            
            let  JSONObject = json as! NSDictionary
            if  JSONObject["results"] is NSArray{
                let  JSONArray =  JSONObject["results"] as! NSArray
                if JSONArray.count > 0{
                    for i:Int in 0  ..< JSONArray.count  {
                        let gResults:GoogleResults = GoogleResults()
                        let resultObject = (JSONArray[i] as AnyObject? as? NSDictionary) ?? ["":""]
                        let  Geometry =  (resultObject["geometry"] as AnyObject? as? NSDictionary) ?? ["":""]
                        let  Location =  (Geometry["location"] as AnyObject? as? NSDictionary) ?? ["":""]
                        gResults.lat = String(describing: (Location["lat"] as AnyObject? as? NSNumber) ?? 0)
                        gResults.lng = String(describing: (Location["lng"] as AnyObject? as? NSNumber) ?? 0)
                        gResults.name = (resultObject["name"] as AnyObject? as? String) ?? ""
                        gResults.vicinity = (resultObject["vicinity"] as AnyObject? as? String) ?? ""
                        gResults.icon =  (resultObject["icon"] as AnyObject? as? String) ?? ""
                         (Location["lng"] as AnyObject? as? String) ?? ""
                        
                        let lt = String(describing: (Location["lat"] as AnyObject? as? NSNumber) ?? 0)
                        let ln = String(describing: (Location["lng"] as AnyObject? as? NSNumber) ?? 0)
                        locations = locations+lt+","+ln+"|"
                        googleResults.append(gResults)
                    }
                    
                    
                    let currentLocation = self.latitude+","+self.longitude
                    
                    let params = [
                        "units":"km",
                        "origins":currentLocation,
                        "destinations":locations,
                        "key":"AIzaSyBJPh21q86pmaelvv9dQGc6uwL5J-QmDqQ"
                    ]
                    
                    
                    print("DISTANCE MATRIX :  ", params)
                    
                    self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
                    Alamofire.request("https://maps.googleapis.com/maps/api/distancematrix/json", method: .get, parameters:params)
                        .validate()
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                print("Validation Successful")
                                self.jsonResultParseDistanceMatrix(response.result.value! as AnyObject)
                                self.stopAnimating()
                            case .failure(let error):
                                print(error)
                                self.viewNoResultsFound.isHidden = false
                                self.tableNearCatList.isHidden=true
                                self.stopAnimating()
                            }

                    }
                   
                }
                else{
                    self.viewNoResultsFound.isHidden = false
                    self.tableNearCatList.isHidden=true
                }
            }
            else{
                self.viewNoResultsFound.isHidden = false
                self.tableNearCatList.isHidden=true
            }
        }
        else{
            self.viewNoResultsFound.isHidden = false
            self.tableNearCatList.isHidden=true
        }
    }
    
    var googleDistance = [GoogleDistance]()
    
    func jsonResultParseDistanceMatrix( _ json:AnyObject){
        
        googleDistance.removeAll()
        if json is NSDictionary{
            
            let  JSONObject = json as! NSDictionary
            
            if  JSONObject["rows"] is NSArray{
                
            let  JSONRowArray =  JSONObject["rows"] as! NSArray
                
                if JSONRowArray[0] is NSDictionary{
                    
                    let  JSONeEementsArray =  JSONRowArray[0] as! NSDictionary
                    
                    let  JSONeEements = JSONeEementsArray["elements"] as! NSArray
                    
                    if JSONeEements.count>0{
                        
                        for i:Int in 0  ..< JSONeEements.count  {
                            
                           // let gDistance:GoogleDistance = GoogleDistance()
                            
                            
                            let distanceObject = (JSONeEements[i] as AnyObject? as? NSDictionary) ?? ["":""]
                            let distance = (distanceObject["distance"] as AnyObject? as? NSDictionary) ?? ["":""]
                            
                            
                            ///gDistance.distnceKM = (distance["text"] as AnyObject? as? String) ?? ""
                            ///gDistance.distanceMtr =  (distance["value"] as AnyObject? as? NSNumber) ?? 0
                            
                            googleResults[i].distancekm = (distance["text"] as AnyObject? as? String) ?? ""
                            googleResults[i].distancem = (distance["value"] as AnyObject? as? NSNumber) ?? 0
                            
                            
                            
                            
                            //self.googleDistance.append(gDistance)
                            
                            
                            
                            
                        }
                        
                        
                        // images.sort({ $0.fileID > $1.fileID })
                        
                        googleResults.sort(by: {Int($0.distancem)<Int($1.distancem)})
                        
                        self.viewNoResultsFound.isHidden = true
                        self.tableNearCatList.isHidden=false
                        self.tableNearCatList.reloadData()
                    
                    }
                    else{
                        self.viewNoResultsFound.isHidden = false
                        self.tableNearCatList.isHidden=true

                    }
                    
                }else{
                    self.viewNoResultsFound.isHidden = false
                    self.tableNearCatList.isHidden=true

                
                }
            
            }
            else{
                self.viewNoResultsFound.isHidden = false
                self.tableNearCatList.isHidden=true

            }
        
        }
        else{
            self.viewNoResultsFound.isHidden = false
            self.tableNearCatList.isHidden=true

        }
        
    
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return googleResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NearBySearchCatagoryListTableViewCell
        cell.imageSearch.backgroundColor = OSColors.GREY200
        cell.title1.text = googleResults[indexPath.row].name
        cell.title2.text = googleResults[indexPath.row].vicinity
//        cell.imageSearch.kf_setImageWithURL(NSURL(string: googleResults[indexPath.row].icon)!)
        
        cell.buttonTitle.setTitle(name, for: UIControlState())
        cell.buttonTitle.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)!

        
//        if Int(googleResults[indexPath.row].distancem) > 1000 {
//            cell.distance.text = googleResults[indexPath.row].distancekm
//        }
//        else{
//            cell.distance.text = String(describing: googleResults[indexPath.row].distancem)+" Mtr"
//        }
        
//        cell.buttonDetails.tag = indexPath.row
//        cell.buttonDetails.addTarget(self, action: #selector(NearBySearchCatagoryListViewController.actionDetails(_:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main3", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "NearBySearchCatagoryDetailViewController") as! NearBySearchCatagoryDetailViewController
        vc1.name = googleResults[indexPath.row].name
        vc1.lat =  googleResults[indexPath.row].lat
        vc1.lng =  googleResults[indexPath.row].lng
        vc1.vicinity =  googleResults[indexPath.row].vicinity
        let navController = UINavigationController(rootViewController: vc1)
        self.present(navController, animated:true, completion: nil)
        //self.presentViewController(vc1, animated: true, completion: nil)
    }
    
    

//    func actionDetails(_ sender:UIButton) {
//        let storyboard = UIStoryboard(name: "Main3", bundle: nil)
//        let vc1 = storyboard.instantiateViewController(withIdentifier: "NearBySearchCatagoryDetailViewController") as! NearBySearchCatagoryDetailViewController
//        vc1.name = googleResults[sender.tag].name
//        vc1.lat =  googleResults[sender.tag].lat
//        vc1.lng =  googleResults[sender.tag].lng
//        vc1.vicinity =  googleResults[sender.tag].vicinity
//        let navController = UINavigationController(rootViewController: vc1)
//        self.present(navController, animated:true, completion: nil)
//        //self.presentViewController(vc1, animated: true, completion: nil)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
    
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func actionOption(_ sender: AnyObject) {
//   self.viewOption.isHidden = false
//    }
    
//    @IBAction func actionShoHideOption(_ sender: AnyObject) {
//        self.viewOption.isHidden = true
//    }
    
//    @IBAction func actionPostBusiness(_ sender: AnyObject) {
//        self.viewOption.isHidden=true
//        self.funcWebView("http://searchdeal.co.in/business-profile/business-public",backTitle: "Post Your Business")
//    }
//    
//    @IBAction func actionFAQ(_ sender: AnyObject) {
//        self.viewOption.isHidden=true
//        self.funcWebView("http://searchdeal.co.in/business-profile/business-public-faq",backTitle: "FAQ")
//    }
    
//    @IBAction func actionLogin(_ sender: AnyObject) {
//        
//        self.viewOption.isHidden=true
//        let DB = LocalDB()
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
    
    func funcInviteFriends(){
        
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)

        //self.presentViewController(vc, animated: true, completion: nil)
    }
    
//    func funcLogin(){
//        
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LOGIN") as! MarchantLoginViewController
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//       // self.presentViewController(vc, animated: true, completion: nil)
//        
//    }
    
//    func funcAfterLogin(){
//        
//        let viewController:UIViewController = UIStoryboard(name: "Main5", bundle: nil).instantiateViewController(withIdentifier: "AddDealViewController") as! AddDealViewController
//        let navController = UINavigationController(rootViewController: viewController)
//        self.present(navController, animated:true, completion: nil)
//       // self.presentViewController(viewController, animated: true, completion: nil)
//        
//        
//    }
    
    func funcWebView( _ url:String, backTitle:String){
        
        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        vc.backTitle = backTitle
        vc.LoadURL = url
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
        //self.presentViewController(vc, animated: true, completion: nil)
        
    }
    

    

}
