//
//  SearchViewController.swift
//  SearchDeal
//
//  Created by Quiqinfotech on 14/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import GooglePlaces
import NVActivityIndicatorView

protocol locationTransferDelegate: class {
    func locationTransfer(place: String?,newLat: String?, newLongi: String?)
}


class SearchViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NVActivityIndicatorViewable {

    @IBOutlet weak var tableSearch: UITableView!
    
    @IBOutlet weak var buttonBack: UIButton!
    
    
    @IBOutlet weak var textSearch: UITextField!
    
    
    @IBOutlet weak var viewNoResultFound: UIView!
    
    @IBOutlet weak var currentLocation: UILabel!
    
    @IBOutlet weak var selectedLocation: UILabel!
    
    weak var delegate: locationTransferDelegate?
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    
    var currentLoca = CLLocation()
    
    let locationManager = CLLocationManager()
    
    fileprivate var responseData:NSMutableData?
    fileprivate var dataTask:URLSessionDataTask?
    fileprivate let baseURLString = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    fileprivate let googleMapsKey = "AIzaSyBvU0kvg2HlmeqvByznMeXjYuptiFtIkvQ"
    
    var page:Int = 0
    var subcatid:String = ""
    var URL:String = ""
    var lat = ""
    var longi = ""
    var locationFromHome = ""
    
    var params = [String:String]()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textSearch.resignFirstResponder()
       
        
        return true
    }
    
    func dismissKeyboard(){
        textSearch.resignFirstResponder()
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textSearch.delegate = self
        
        tableSearch.delegate = self
        tableSearch.dataSource = self
        
        textSearch.clearButtonMode = .whileEditing
        textSearch.tintColor = OSColors.LIGHTBLUE600
        
        textSearch.allowsEditingTextAttributes = true
        self.textSearch.autocorrectionType = UITextAutocorrectionType.no
        
        print("LAT123 = \(lat)")
        print("Longi123 = \(longi)")
        
        self.selectedLocation.text = locationFromHome.isEmpty ? "Kochi" : locationFromHome
        
        
        self.tableSearch.isHidden = false
        self.viewNoResultFound.isHidden = true
        
        

        textSearch.addTarget(self, action: #selector(SearchViewController.textChanged(_:)), for: UIControlEvents.editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Add the search bar to the right of the nav bar,
        // use a popover to display the results.
        // Set an explicit size as we don't want to use the entire nav bar.
        searchController?.searchBar.frame = (CGRect(x: 0, y: 0, width: 250.0, height: 44.0))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: (searchController?.searchBar)!)
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Keep the navigation bar visible.
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.modalPresentationStyle = .popover
        
       // NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 5
       // NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 5
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func autocompleteClicked(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        
 //       let bounds = GMSCoordinateBounds(coordinate: , coordinate: visibleRegion.nearRight)
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController, animated: true, completion: nil)
    
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
    
        self.searchController?.view.removeFromSuperview()
     self.dismiss(animated: true, completion: nil)
    }
    
    
   
    
    
    
    
    @IBAction func findCurrentLocation(_ sender: Any) {
        
        if CLLocationManager.authorizationStatus() == .denied{
            
            let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                
            }))
            
            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alertControllerz, animated: true, completion: nil)
        }else{
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
            //let size = CGSize(width: 30, height: 30)
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                print("Authenticating.....1234")
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.stopAnimating()
            }

            
            

        }
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
//        if CLLocationManager.authorizationStatus() == .denied{
//            
//            let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)
//            
//            alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
//                
//                UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
//                
//            }))
//            
//            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
//            }))
//            
//            self.present(alertControllerz, animated: true, completion: nil)
//        }else{
        
        
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            print("Address = \(containsPlacemark)")
            
            var currentLat = ""
            var currentlongi = ""
            
            if let currLoc = locationManager.location{
                currentLoca = currLoc
                
                currentLat = "\(currentLoca.coordinate.latitude)"
                currentlongi = "\(currentLoca.coordinate.longitude)"

            }
            
            
           
             let thoroughfare = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
            let sublocality = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality : ""
            let subAdministrativeArea = (containsPlacemark.subAdministrativeArea != nil) ? containsPlacemark.subAdministrativeArea : ""
            
            self.stopAnimating()
            print("LOCATION Address = \(thoroughfare! + ", " + sublocality! + ", " + subAdministrativeArea!)")
            
            self.currentLocation.text = thoroughfare! + ", " + sublocality! + ", " + subAdministrativeArea!
            
            self.selectedLocation.text = thoroughfare! + ", " + sublocality! + ", " + subAdministrativeArea!
            
//            UserDefaults.standard.removeObject(forKey: "savedSelectedLatitude")
//            UserDefaults.standard.removeObject(forKey: "savedSelectedLongitude")
//            UserDefaults.standard.removeObject(forKey: "savedSelectedLocName")
            
            UserDefaults.standard.set(subAdministrativeArea, forKey: "savedSelectedLocName")
            UserDefaults.standard.set(currentLat, forKey: "savedSelectedLatitude")
            UserDefaults.standard.set(currentlongi, forKey: "savedSelectedLongitude")
            
            transferPlaceData(locationData: subAdministrativeArea!, NEWLat: currentLat, NEWLongi: currentlongi)
            
        }
     // }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }

    
    func textChanged(_ sender:UITextField){
        
        SubCatMasterList.removeAll()
        tableSearch.reloadData()
        
        print(" SubCatMasterList COUNT : ", SubCatMasterList.count)
        
        let s:AnyObject = textSearch.text! as AnyObject
        
        print(s as! String )
        
        print("LAT123 = \(lat)")
        print("Longi123 = \(longi)")
        
        
        if page == 0 {
            
            self.params = [ "keyword":s as! String,
                            "subcatid": self.subcatid,
                            "lat": self.lat,
                            "long": self.longi ]
            
            self.URL = urlClass().url1 + "searchallcopy.php"
        }
        else if page == 1{
            self.params = [
                "keyword":s as! String,
                "subcatid": self.subcatid,
                "lat": self.lat,
                "long": self.longi
            ]
            self.URL = urlClass().url1 + "searchallcopy.php"
        }
        
        
        print("PARAMS  : ",self.params)
        print("URL  : ",self.URL)
        
        
        Alamofire.request( self.URL, method: .get, parameters: self.params)
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
    
    func transferPlaceData( locationData: String, NEWLat: String,  NEWLongi:String){
        
        delegate?.locationTransfer(place: locationData, newLat: NEWLat, newLongi: NEWLongi)
    }
    
    
     var SubCatMasterList = [SubCatagoryMasterList]()
    
    
    func jsonResultParse( _ json:AnyObject){
        
        SubCatMasterList.removeAll()
        
        
        let JSONArray = json as! NSArray
        
        print("JSON COUNT ",JSONArray.count)
        
        if JSONArray.count != 0 {
            
            self.tableSearch.isHidden = false
            self.viewNoResultFound.isHidden = true
            
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
             //   uCatagory.dealofferprice = (jObject["dealofferprice"] as AnyObject? as? NSNumber) ?? 0
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
                
                SubCatMasterList.append(uCatagory)
                
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
        
        print( "TABLE  SubCatMasterList COUNT ; ",SubCatMasterList.count)
        return SubCatMasterList.count
    }
    
    var SubcatMaster:SubCatagoryMasterList = SubCatagoryMasterList()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        SubcatMaster = SubCatMasterList[indexPath.row]
        let imgurl:String = SubcatMaster.photo.replacingOccurrences(of: " ", with: "%20")
        cell.imageSearch.backgroundColor = OSColors.GREY200
        cell.imageSearch.kf.setImage(with: Foundation.URL(string: imgurl)!,placeholder: nil)
        
        
        cell.title1.text = SubcatMaster.name
        cell.title2.text = SubcatMaster.category2
//        cell.head2.textColor = OSColors.MyColor(SubcatMaster.ccode)
        cell.title2.textColor = AppColor.LightGrey
        cell.title3.text = SubcatMaster.city+","+SubcatMaster.state
        cell.distanceLabel.text = SubcatMaster.distance
        cell.reachesLabel.text = SubcatMaster.reach
        cell.likeLabel.text = SubcatMaster.like
        
        //cell.title4.text = SubcatMaster.state
        
        //cell.title3.textColor = AppColor.LightGrey
        //cell.title4.textColor = AppColor.LightGrey
        
        //cell.title5.textColor = UIColor.redColor()
        //cell.title5.text = SubcatMaster.dealstatus
        
//        cell.buttonSelect.tag = indexPath.row
//        cell.buttonSelect.addTarget(self, action: #selector(SearchViewController.actionDetails(_:)), for: UIControlEvents.touchUpInside)
        return cell
        
    }
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SubcatMaster = SubCatMasterList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
        
        vc1.SubcatMasterList = SubcatMaster
        
        // let navController = UINavigationController(rootViewController: vc1)
        self.present(vc1, animated:true, completion: nil)


    }

    

    
}

extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        print("Place coordinates latitude: \(place.coordinate.latitude)")
        
        lat = "\(place.coordinate.latitude)"
        longi = "\(place.coordinate.longitude)"
        
        
        self.selectedLocation.text = place.formattedAddress!
        self.currentLocation.text = "Auto detect location"
        
        var  administrative_area_level_2 = ""
        
        // Get the address components.
        if let addressLines = place.addressComponents {
            // Populate all of the address fields we can find.
            for field in addressLines {
                switch field.type {
               
                case kGMSPlaceTypeAdministrativeAreaLevel2:
                    administrative_area_level_2 = field.name
                
                // Print the items we aren't using.
                default:
                    print("Type: \(field.type), Name: \(field.name)")
                }
            }
        }
        
        UserDefaults.standard.set(administrative_area_level_2, forKey: "savedSelectedLocName")
        UserDefaults.standard.set(lat, forKey: "savedSelectedLatitude")
        UserDefaults.standard.set(longi, forKey: "savedSelectedLongitude")
        
        transferPlaceData(locationData: administrative_area_level_2, NEWLat: lat, NEWLongi: longi)
        

        // user to fill the selected location label
        self.selectedLocation.text = place.formattedAddress!

        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        
  }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

