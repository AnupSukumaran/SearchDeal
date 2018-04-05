//
//  HomePageViewController.swift
//  SearchDeal
//
//  Created by Quiqinfotech on 09/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import NVActivityIndicatorView
import DropDown
import CoreLocation
import MXParallaxHeader





class HomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NVActivityIndicatorViewable,CLLocationManagerDelegate, locationTransferDelegate, MXParallaxHeaderDelegate {

    //MARK: The Begining
   private var lastContentOffset: CGFloat = 0
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var bottomContrains: NSLayoutConstraint!
   
    @IBOutlet weak var circleBottomDistance: NSLayoutConstraint!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var homeTable: UITableView!
    
    @IBOutlet var droppingView: UIView!
    
    @IBOutlet var headerNewView: UIView!
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    
    @IBOutlet weak var searchBarView: UIView!
    
    
    @IBOutlet weak var labelView: UIView!
    
    
    var initialStatusBarStyle : UIStatusBarStyle!
     var initialStatusBarView : UIColor!

    var imageIcons = ["Hotels2", "Restaurant", "travel", "automotive", "Hair", "fashion", "General", "entertainment", "education", "Manufactureing","sports","pets", "Events","Estate","legals","constructs","jewellery","gifts","arts","jobs","medicine","software", "banks", "press"]
    
    
    let leftMenuDropDown = DropDown()
    
    lazy var dropDown: [DropDown] = {
        return [self.leftMenuDropDown]
    }()

    
    let vieweffects = ViewEffects()
    var catagory = [UserCatagory]()
    //var locations = [locationMode]()
    
     let locations:locationMode = locationMode()
    
    var headerView: UIView!
    
    var DynamicView:UIView!
    
    var DynamicBtn:UIButton = UIButton(frame:CGRect(x: 0, y: 0, width: 80, height: 80))
    
    var swipeGesture:UISwipeGestureRecognizer!
    var swipeDown:UISwipeGestureRecognizer!

    
    var latitude:String = "9.9312328"
    var longitude:String = "76.2673041"
    var newPlace = ""
    
    var currentLocation = CLLocation()
    
    let locationManager = CLLocationManager()
    
       var SwipeFlag = false
    
    var droopingViewHeight = CGFloat()
    //MARK: ViewDidApppear
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        
        droopingViewHeight = droppingView.frame.height
        print("Heught123 = \(droopingViewHeight)")
        
        print("First Distance = \(self.circleBottomDistance.constant)")
        self.circleBottomDistance.constant = droopingViewHeight/2 
        print("Second Distance = \(self.circleBottomDistance.constant)")
        
        homeTable.parallaxHeader.minimumHeight = 56
    }
    
    func locationTransfer(place: String?,newLat: String?, newLongi: String?) {
        
        if let newPlace = place{
            
            self.newPlace = newPlace
            
            print("PLACE123 = \(newPlace)")
            self.locationLabel.text = "in " + newPlace
            
        }
        
        if let newlatti = newLat{
            latitude = newlatti
           // print("NEWLAT = \(newlatti)")
        }
        if let newlongii = newLongi{
            longitude = newlongii
           // print("NEWLONGI = \(newlongii)")
        }
       
    }
    
    
    
    
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
        print("SCROLLDirecOFWillBegin = \(scrollView.contentOffset.y)")
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            
            print("SCROLLDirecOFDIDBegin1 == \(self.lastContentOffset) < \(scrollView.contentOffset.y)")
            
            downzzzzs()
            
            // changeTabBar(hidden: true, animated: true)
            // moved to top
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            
            print("SCROLLDirecOFDIDBegin2 == \(self.lastContentOffset) < \(scrollView.contentOffset.y)")
            
             upzzzs()
            
             //changeTabBar(hidden: false, animated: true)
            // moved to bottom
        } else {
            
            // didn't move
        }
    }
    
    
    func upzzzs(){
        bottomContrains.constant = 0
        
        UIView.animate(withDuration: 0.5, animations: {self.view.layoutIfNeeded()})
        
    }
    
    func downzzzzs(){
        
        bottomContrains.constant = -(droppingView.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {self.view.layoutIfNeeded()})
        
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        
        print("Hidden = \(hidden)")
        let tabBar = self.droppingView
        if tabBar!.isHidden == hidden{
           
            print("EXITED")
            return
            
            
        }
        print("Not EXITED")
        
        let framess = tabBar?.frame
        print("HIGGS = \(framess!)")
        let offset = (hidden ? (framess?.size.height)! : -(framess?.size.height)!)
        print("OFFSET = \(offset)")
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar?.isHidden = false
        if framess != nil
        {
            UIView.animate(withDuration: duration,
                           animations: {tabBar!.frame = framess!.offsetBy(dx: 0, dy: offset)},
                           completion: {
                            print("NUM = \($0)")
                            if $0 {tabBar?.isHidden = hidden}
            })
        }
    }
    

    
    
    @IBAction func showMenuButon(_ sender: Any) {
        leftMenuDropDown.show()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocalDB.DBInit()
        homeTable.delegate = self
        homeTable.dataSource = self
        
        
        let droopingViewHeight = droppingView.frame.height
        print("Heught = \(droopingViewHeight)")
//        UIApplication.shared.statusBarStyle = .lightContent
//
//        UINavigationBar.appearance().clipsToBounds = true
//
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//
//        statusBar.backgroundColor = UIColor.white
//
        
        homeTable.parallaxHeader.view = headerNewView
        
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                homeTable.rowHeight = 185
                
                homeTable.parallaxHeader.height = 200
            
        // It's an iPhone
            case .pad:
                homeTable.rowHeight = 300
               
                homeTable.parallaxHeader.height = 300
            case .unspecified:
                print("nil")
            case .tv:
                print("nil")
            case .carPlay:
                print("nil")
        }
        
        
        homeTable.parallaxHeader.mode = MXParallaxHeaderMode.fill
        homeTable.parallaxHeader.delegate = self
        
        
        self.setupLeftMenuBarDropDown()
        leftMenuDropDown.dismissMode = .onTap
        leftMenuDropDown.direction = .bottom
        
        leftMenuDropDown.bottomOffset = CGPoint(x: 12, y: (leftMenuDropDown.anchorView?.plainView.bounds.height)!)
        
        leftMenuDropDown.backgroundColor = UIColor.white
        leftMenuDropDown.selectionBackgroundColor = UIColor.white
        leftMenuDropDown.cellHeight = 50
        
        leftMenuDropDown.width = 180
       // leftMenuDropDown.textFont = UIFont.systemFont(ofSize: 18)
       leftMenuDropDown.textFont = UIFont(name: "Poppins-Regular", size: 16)!
        
        //leftMenuDropDown.separatorColor = UIColor.black
        
        self.locationLabel.text = "in Kochi"
        locations.latitude = "9.9312328"
        locations.longitude = "76.2673041"
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
//            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
//            
//            if let  curLocation = locationManager.location{
//                currentLocation = curLocation
//                latitude = "\(currentLocation.coordinate.latitude)"
//                longitude = "\(currentLocation.coordinate.longitude)"
//                print("Latitude = \(currentLocation.coordinate.latitude)")
//                print("Longitude = \(currentLocation.coordinate.longitude)")
//            }else{
//                print("LOCATION not found")
//            }
//            
//        }
        
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "usercategorylistcopy.php", method: .post, parameters: ["": ""])
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
                    
                }
                
               
        }
        
        
    }
    
    // MARK: - Parallax colour change
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        NSLog("progress %f", parallaxHeader.progress)
        
        if parallaxHeader.progress <= 0.583333{
            
            labelView.isHidden = true
            
        }else{
            labelView.isHidden = false
        }
        
        
        if parallaxHeader.progress <= 0.3472220{
            
            UIView.animate(withDuration: 0.4){
                self.headerNewView.backgroundColor = UIColor(red: 200/255, green: 10/255, blue: 10/255, alpha: 1)
            }
            
            searchBarView.isHidden = true
            imageBanner.isHidden  = true
            //labelView.isHidden = true
            
            
        }else{
           
            UIView.animate(withDuration: 0.4){
                self.headerNewView.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
            }
            
            searchBarView.isHidden = false
            imageBanner.isHidden  = false
          //  labelView.isHidden = false
            
            
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        print("WillAppear")
        //        UIApplication.shared.statusBarStyle = .lightContent
        //
        //        UINavigationBar.appearance().clipsToBounds = true
        //
       
        //
        
       // super.viewWillAppear(animated)
      let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        initialStatusBarView = statusBar.backgroundColor
        
       //UIApplication.shared.statusBarStyle = .lightContent
      //  UINavigationBar.appearance().clipsToBounds = true
      //  let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        
        statusBar.backgroundColor = UIColor.white
        
        
        upzzzs()
        
        
        if UserDefaults.standard.object(forKey: "savedSelectedLatitude") != nil{
            
            latitude = UserDefaults.standard.object(forKey: "savedSelectedLatitude") as! String
            
            longitude = UserDefaults.standard.object(forKey: "savedSelectedLongitude") as! String
            
            locations.latitude = UserDefaults.standard.object(forKey: "savedSelectedLatitude") as! String
            
            
            locations.longitude = UserDefaults.standard.object(forKey: "savedSelectedLongitude") as! String
            
            
        }
        
        if UserDefaults.standard.object(forKey: "savedSelectedLocName") != nil{
            
            let oldPlace =  UserDefaults.standard.object(forKey: "savedSelectedLocName") as! String
            
            self.locationLabel.text = "in " + oldPlace
            print("PLACE123456 = \(oldPlace)")
            self.newPlace = oldPlace
        }
        
        
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        print("VDisapplear")

       let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = initialStatusBarView
       
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if CLLocationManager.authorizationStatus() == .denied{
            
            let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                
            }))
            
            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alertControllerz, animated: true, completion: nil)
        }else{
            
            
            if let containsPlacemark = placemark {
                //stop updating location to save battery life
                locationManager.stopUpdatingLocation()
             
               

                
                if let currLoc = locationManager.location{
                    currentLocation = currLoc
                    
                    if UserDefaults.standard.object(forKey: "savedSelectedLatitude") != nil{
                        
                        locations.latitude = UserDefaults.standard.object(forKey: "savedSelectedLatitude") as! String
                        
                        locations.longitude = UserDefaults.standard.object(forKey: "savedSelectedLongitude") as! String
                        
                        latitude = UserDefaults.standard.object(forKey: "savedSelectedLatitude") as! String
                        
                        longitude = UserDefaults.standard.object(forKey: "savedSelectedLongitude") as! String
                    }else{
                        
                        latitude = "\(currentLocation.coordinate.latitude)"
                        longitude = "\(currentLocation.coordinate.longitude)"
                        
                        locations.latitude = "\(currentLocation.coordinate.latitude)"
                        
                        locations.longitude = "\(currentLocation.coordinate.longitude)"
                        
                      
                       
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
            
                let subAdministrativeArea = (containsPlacemark.subAdministrativeArea != nil) ? containsPlacemark.subAdministrativeArea : ""
                
                if UserDefaults.standard.object(forKey: "savedSelectedLocName") != nil{
                    
                    let oldPlace =  UserDefaults.standard.object(forKey: "savedSelectedLocName") as! String
                    
                    self.locationLabel.text = "in " + oldPlace
                    print("PLACE123456 = \(oldPlace)")
                    self.newPlace = oldPlace
                }else{
                   
                   
                self.locationLabel.text = "in " + subAdministrativeArea!
                    self.newPlace = subAdministrativeArea!
                     print("PLACE123456 = \(String(describing: subAdministrativeArea))")
                }
                
                
            
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }

    
   
    
    
    
    func actionDynamicNearBy(_ sender:UIButton){
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "NearBySearchFromHomeViewController") as! NearBySearchFromHomeViewController
        
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
        
        
        
    }
    
    
    
    
    func jsonResultParse( _ json:AnyObject){
        
        catagory.removeAll()
        
        
        let JSONArray = json as! NSArray
        
        print("jsonArray = \(JSONArray)")
        
        if JSONArray.count != 0 {
            _ = [UserCatagory]()
            
         
            
            for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
                let uCatagory:UserCatagory = UserCatagory()
                uCatagory.id = (jObject["id"] as AnyObject? as? String) ?? ""
                uCatagory.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                uCatagory.ccode = (jObject["ccode"] as AnyObject? as? String) ?? ""
                uCatagory.deals = (jObject["deals"] as AnyObject? as? String) ?? ""
                uCatagory.members = (jObject["members"] as AnyObject? as? String) ?? ""
                uCatagory.name = (jObject["name"] as AnyObject? as? String) ?? ""
                uCatagory.result = (jObject["result"] as AnyObject? as? String) ?? ""                
                catagory.append(uCatagory)
            }
            
            self.homeTable.reloadData()
            
        }
        
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    func setupLeftMenuBarDropDown(){
        
        leftMenuDropDown.anchorView = menuButton
        
        leftMenuDropDown.dataSource = ["Post Your Business",
                                       "FAQ",
                                       "Merchant Login",
                                       "Invite Friends"]
        
        leftMenuDropDown.selectionAction = { (index: Int, item: String) in switch index{
        case 0:  self.funcWebView("http://searchdeal.co.in/business-profile/business-public",backTitle: "Post Your Business")
        case 1:  self.funcWebView("http://searchdeal.co.in/business-profile/business-public-faq",backTitle: "FAQ")
        case 2:
//            let DB = LocalDB()
//        
//            if DB.getEmail() != "" {
//                self.funcAfterLogin()
//            }
//            else{
                self.funcLogin()
            //}

        case 3:
            let storyboard = UIStoryboard(name: "Main2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated:true, completion: nil)
            
        default: print("Not valid")
            }
        }
        
        leftMenuDropDown.selectionBackgroundColor = UIColor.white
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return catagory.count/2
        
    }
    
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomePageTableViewCell
        
        
        let check:Int = indexPath.row*2
        if catagory.count > check{
        cell.labelName1.text = catagory[check].name
        cell.labelDeals1.text = catagory[check].members
            cell.button1.tag = check
            
            let imgUrl = URL(string: catagory[check].photo)
            cell.image1.backgroundColor = OSColors.GREY200
            
            cell.image1.kf.setImage(with: imgUrl!,placeholder: nil)
            
            
           
            
            cell.leftCellTopIcons.image = UIImage(named:imageIcons[check])

            
            
            
            if catagory.count > check+1{
                
                cell.labelName2.text = catagory[check+1].name
                cell.labelDeals2.text = catagory[check+1].members
                cell.button2.tag = check+1
                
                let imgUrl1 = URL(string: catagory[check+1].photo)
              

                cell.image2.backgroundColor = OSColors.GREY200
                cell.image2.kf.setImage(with: imgUrl1!,placeholder: nil)
                cell.rightCellTopIcons.image = UIImage(named:imageIcons[check+1])
            }
            
        }
        
        cell.button1.addTarget(self, action: #selector(HomePageViewController.actionButton1(_:)), for: UIControlEvents.touchUpInside)
        cell.button2.addTarget(self, action: #selector(HomePageViewController.actionButton2(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        return cell
    }
    
    
    
    
    func actionButton1(_ sender:UIButton)
    {
        
        self.funcSubcatagory(catagory[sender.tag].id,name: catagory[sender.tag].name, imageURLData: catagory[sender.tag].photo, ImageIconNum: sender.tag, reachesCount: catagory[sender.tag].members, ImageIconName: imageIcons[sender.tag])
    
    }
    
    
    func actionButton2(_ sender:UIButton)
    {
        
        self.funcSubcatagory(catagory[sender.tag].id,name: catagory[sender.tag].name, imageURLData: catagory[sender.tag].photo, ImageIconNum: sender.tag, reachesCount: catagory[sender.tag].members, ImageIconName: imageIcons[sender.tag])

        
    }

    
    func funcSubcatagory(_ sid:String,name:String,imageURLData:String, ImageIconNum:Int, reachesCount: String, ImageIconName: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SubCatagoryViewController") as! SubCatagoryViewController
        vc1.cat_id = sid
        vc1.cat_title = name
        vc1.photoData = imageURLData
        vc1.latitude = latitude
        print("LAtitude = \(latitude)")
        print("Lonigyide = \(longitude)")
        vc1.longitude = longitude
        vc1.iconNum = ImageIconNum
        vc1.reachesCount = reachesCount
        vc1.iconName = ImageIconName
        vc1.newPlace = self.newPlace
        
        let navController = UINavigationController(rootViewController: vc1)
        self.present(navController, animated:true, completion: nil)
        
        
        
        
    }

    

    @IBAction func actionSearch(_ sender: AnyObject) {
        
        let new = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "SEARCH") as! SearchViewController
        new.delegate = self
        new.lat = latitude
        new.longi = longitude
        new.locationFromHome =  self.newPlace
        self.present(new, animated: true, completion: nil)
        
    }
    

    var isHighLighted = false
    

    @IBAction func NearBySearch(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NearBySearchFromHomeViewController") as! NearBySearchFromHomeViewController
        
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)

        
    }
    
    @IBAction func PostBusinessButton(_ sender: Any) {
        
        
            if (UserDefaults.standard.object(forKey: "Login") as? String) != nil{
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MerchantMainViewController") as! MerchantMainViewController
                
                let navController = UINavigationController(rootViewController: vc)
                
                
                self.present(navController, animated:true, completion: nil)
            }else{
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
                
                self.present(vc, animated:true, completion: nil)
                
            }
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    //MARK: DealsPageButtonFunc
    
    @IBAction func DealsPage(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DealsCollectionViewController") as! DealsCollectionViewController
        
        vc.myLocation = locations
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
        
//        let alert = UIAlertController(title: "Coming Soon", message: "Under development", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)

    }
    

    
    
    @IBAction func qrScannerPage(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QrCodeViewController") as! QrCodeViewController
        
//        vc.latitude = locations.latitude
//        vc.longitude = locations.longitude
        
        vc.locations = locations
        //let navController = UINavigationController(rootViewController: vc)
        // self.presentViewController(navController, animated:true, completion: nil)
        self.present(vc, animated: true, completion: nil)

    }
    
    
    
    
    func funcInviteFriends(){
        
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)

       // self.presentViewController(vc, animated: true, completion: nil)

    
    }
    
    func funcLogin(){
        
        if (UserDefaults.standard.object(forKey: "Login") as? String) != nil{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MerchantMainViewController") as! MerchantMainViewController
            
            let navController = UINavigationController(rootViewController: vc)
            
            
            self.present(navController, animated:true, completion: nil)
        }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
            
            self.present(vc, animated:true, completion: nil)
            
        }
        
    }
    
  
    
    func funcWebView( _ url:String, backTitle:String){
        
        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        vc.backTitle = backTitle
        vc.LoadURL = url
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
      //  self.presentViewController(vc, animated: true, completion: nil)
        
    }


    
//    func funcAllDeals(){
//        
//        let storyboard = UIStoryboard(name: "Main3", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "AllDealsViewController") as! AllDealsViewController
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated:true, completion: nil)
//       // self.presentViewController(vc, animated: true, completion: nil)
//
//    }
    
    
    
}
