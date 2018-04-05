//
//  SearchViewController.swift
//  SearchDeal
//
//  Created by Quiqinfotech on 14/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import CoreLocation

class SearchViewController2: UIViewController,NVActivityIndicatorViewable,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var tableSearch: UITableView!
    
    @IBOutlet weak var buttonBack: UIButton!
    
    
    @IBOutlet weak var textSearch: UITextField!
    
    
    @IBOutlet weak var viewNoResultFound: UIView!
    
   // var page:Int = 0
   // var subcatid:String = ""
    var nameTitle:String = ""
    var URL:String = ""
    
    var params = [String:String]()
    
     var nearByCatagory = [NearBySearchCatagory]()
    
    var userSea = [UserSearch]()
    
    let locationManager = CLLocationManager()
    
    
    let vieweffects = ViewEffects()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textSearch.resignFirstResponder()
        
        
        return true
    }
    
    func dismissKeyboard(){
        textSearch.resignFirstResponder()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        textSearch.delegate = self
        
        tableSearch.delegate = self
        tableSearch.dataSource = self
        
        textSearch.clearButtonMode = .whileEditing
        textSearch.tintColor = OSColors.LIGHTBLUE600
        
        textSearch.allowsEditingTextAttributes = true
        self.textSearch.autocorrectionType = UITextAutocorrectionType.no
        
        //        let image = UIImage(named: "ic_arrow_back")?.imageWithRenderingMode(.AlwaysTemplate)
        //        buttonBack.setImage(image, forState: .Normal)
        //        buttonBack.tintColor = OSColors.LIGHTBLUE600
        
        self.tableSearch.isHidden = false
        self.viewNoResultFound.isHidden = true
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        
        self.URL = urlClass().url1 + "apideals/usercategorylistsearch.php"
        Alamofire.request(self.URL, method: .get, parameters: self.params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    self.stopAnimating()
                case .failure(let error):
                    print(error)
                    self.tableSearch.isHidden = true
                    self.viewNoResultFound.isHidden = false
                    self.stopAnimating()
                    // return userCatagory
                }
        }
        
        
        textSearch.addTarget(self, action: #selector(SearchViewController2.textChanged(_:)), for: UIControlEvents.editingChanged)
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController2.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textChanged(_ sender:UITextField){
        
        userSea.removeAll()
        tableSearch.reloadData()
        
        print(" userSea COUNT : ", userSea.count)
        
        let s:AnyObject = textSearch.text! as AnyObject
        
        print(s as! String )
        
        
      //  if page == 0 {
            
            self.params = [ "keyword":s as! String]
      //  self.params = ""
            
            self.URL = urlClass().url1 + "apideals/usercategorylistsearch.php"
       // }
      //  else if page == 1{//
//            self.params = [
//                "keyword":s as! String,
//                "subcatid": self.subcatid
//            ]
//            self.URL = "http://searchdeal.co.in/business-ios/key/searchallsub.php"
//        }
        
        
        print("PARAMS  : ",self.params)
        print("URL  : ",self.URL)
        
        
        Alamofire.request(self.URL, method: .get, parameters: self.params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                case .failure(let error):
                    print(error)
                    self.tableSearch.isHidden = true
                    self.viewNoResultFound.isHidden = false
                    // return userCatagory
                }
        }
        
        
        
        
        
        
    }
    
    
    var SubCatMasterList = [SubCatagoryMasterList]()
    
    
    func jsonResultParse( _ json:AnyObject){
        
        userSea.removeAll()
        
        
        let JSONArray = json as! NSArray
        
        print("JSON COUNT ",JSONArray.count)
        
        if JSONArray.count != 0 {
            
            self.tableSearch.isHidden = false
            self.viewNoResultFound.isHidden = true
            
            for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
                let uCatagory:UserSearch = UserSearch()
                
               
                
                uCatagory.id = (jObject["id"] as AnyObject? as? String) ?? ""
                uCatagory.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                uCatagory.type = (jObject["type"] as AnyObject? as? String) ?? ""
                uCatagory.radius = (jObject["radius"] as AnyObject? as? String) ?? ""
                uCatagory.name = (jObject["name"] as AnyObject? as? String) ?? ""
                uCatagory.result = (jObject["result"] as AnyObject? as? String) ?? ""
                
                userSea.append(uCatagory)
                
            }
            
            self.tableSearch.reloadData()
            
        }
        else{
            
            self.tableSearch.isHidden = true
            self.viewNoResultFound.isHidden = false
            
        }
        
        
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        //print( "TABLE  SubCatMasterList COUNT ; ",SubCatMasterList.count)
        return userSea.count
    }
    
    var SubcatMaster:SubCatagoryMasterList = SubCatagoryMasterList()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell2
      //  let check:Int = indexPath.row*2
       // if userSea.count > check{
            cell.title1.text = userSea[indexPath.row].name
            
       // if userSea.count > check+1{
                
              //  cell.labelName2.text = userSea[check+1].name
             //   cell.labelDeals2.text = "Nearby"
             //   cell.button2.tag = check+1
                
             //   let imgUrl1 = NSURL(string: nearByCatagory[check+1].photo)
                // cell.labelName2.textColor = OSColors.MyColor(catagory[check+1].ccode)
                
            //    cell.image2.backgroundColor = OSColors.GREY200
             //   cell.image2.kf_setImageWithURL(imgUrl1!,placeholderImage: nil)
        //    }
            
       // }
        
        cell.buttonSelect.tag = indexPath.row
        cell.buttonSelect.addTarget(self, action: #selector(SearchViewController2.actionDetails(_:)), for: UIControlEvents.touchUpInside)
        return cell
        
    }
    
   
    
    

    
    func actionDetails(_ sender:UIButton){
        
        if CLLocationManager.authorizationStatus() == .denied{
            
            let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                UIApplication.shared.openURL(Foundation.URL(string: UIApplicationOpenSettingsURLString)!)
                
            }))
            
            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alertControllerz, animated: true, completion: nil)
        }
            
        else{
            
            // self.locationManager.startUpdatingLocation()
            print("LATITUDE : ",self.latitude)
            print("LONGITUDE : ",self.longitude)
            let currentLocation = self.latitude+","+self.longitude
            if self.latitude == "" || self.longitude  == "" {
                let alert = UIAlertView(title: OSConstants.APPLICATION_NAME(), message: "Location not found", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
                
            else{
                self.funcSubcatagory(userSea[sender.tag].radius,typ: userSea[sender.tag].type,nam: userSea[sender.tag].name)
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
        
        //self.presentViewController(vc1, animated: true, completion: nil)
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

    
    
}
