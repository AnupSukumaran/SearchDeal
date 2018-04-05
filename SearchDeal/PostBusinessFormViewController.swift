//
//  PostBusinessFormViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 27/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import GooglePlacePicker
import CoreLocation
import DropDown
import SkyFloatingLabelTextField
import ImagePicker
import Alamofire
import NVActivityIndicatorView
import Auk
import moa

class catMenu{
    var id:Int = 0
    var name:String = ""
}



class PostBusinessFormViewController: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, ImagePickerDelegate, NVActivityIndicatorViewable, UIScrollViewDelegate {

    @IBOutlet weak var openingTime: UIDatePicker!
    @IBOutlet weak var closingTime: UIDatePicker!
    
    @IBOutlet weak var addLocationOutlet: UIButton!
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    @IBOutlet weak var categoryOutlet: UIButton!
    @IBOutlet weak var subCategoryOutlet: UIButton!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
  //  @IBOutlet weak var businessTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var businessTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var descriptionTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var doorNoTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var streetTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var pinCodeTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var websiteTextField: SkyFloatingLabelTextField!
    
    
    
    
    var currentLocation = CLLocation()
    
    let locationManager = CLLocationManager()
    
    var Mylocations:locationMode = locationMode()
    
   //let imagePicker = UIImagePickerController()
    //let imagePickerController = ImagePickerController()
    let imagePicker = ImagePickerController()
    let chooseArticleDropDown = DropDown()
    let chooseArticleDropDown2 = DropDown()
    
    let uservalue = UserDefaults.standard.object(forKey: "userUniqueId") as! String
    
    
   
    
    lazy var dropDowns: [DropDown] = {
        return [self.chooseArticleDropDown,
                self.chooseArticleDropDown2]
    }()
    
    var storedValueForMenu1 = "SUV"
    var closeTime = ""
    var openTime = ""
    var SelectedPlaceInfo = [String]()
    
    var textFields: [SkyFloatingLabelTextField] = []

    var params = [String: String]()
    
    var locationInProgress: Bool = true
    
    var catMenuBox = [catMenu]()
    var CaTMenuNewBox:[String] = []
    var CaTMenuNewBoxForId:[Int] = []
    var SubCaTMenuNewBox:[String] = []
    var SubCaTMenuNewBoxForId:[Int] = []

    var i:Int = 0
    
    var imageData:[UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
       
        
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
         textFields = [businessTextField, descriptionTextField, doorNoTextField, streetTextField, cityTextField,  stateTextField, pinCodeTextField, emailTextField, phoneTextField, websiteTextField]
        
        for textField in textFields {
            textField.delegate = self
        }
        
        phoneTextField.text = UserDefaults.standard.object(forKey: "PhoneBeforeSubmit") as? String
        phoneTextField.isEnabled = false
        print("PHONE123332 = \(String(describing: phoneTextField.text))")
        
         setupUser()
        
//        let timeFormat = DateFormatter()
//        timeFormat.dateFormat = "HH:mm"
//
//
//        openingTime.date = timeFormat.date(from: "00:00")!
//        closingTime.date = timeFormat.date(from: "00:00")!
//
         categoryMenuURL()
       
      // *MARK -  Dismiss keyboard with touching the background
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        
       // showInitialImage()
        
        scrollView.auk.settings.contentMode = UIViewContentMode.scaleAspectFill
  
    }
    
    //MARK: AUK Implented Intial Image setup
//    private func showInitialImage() {
//
//        self.activeIndicator.startAnimating()
//
//        scrollView.auk.settings.contentMode = UIViewContentMode.scaleAspectFill
//
//
//        if !self.businessDetails.photo.isEmpty {
//
//            // scrollView.auk.removeAll()
//            let imgUrl = URL(string: self.businessDetails.photo)
//            DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
//                let fetch = NSData(contentsOf: imgUrl! as URL)
//                // print("HIT1")
//                DispatchQueue.main.async {
//                    if let imageData = fetch  {
//                        self.activityIndicator.stopAnimating()
//                        let imageForm = UIImage(data: imageData as Data)
//                        self.scrollView.auk.settings.pageControl.backgroundColor = UIColor.purple.withAlphaComponent(0.3)
//                        self.scrollView.auk.show(image: imageForm!)
//
//                    }
//                }
//
//            }
//
//            //            print("IMAGEURL123 = \(businessDetails.photo)")
//            //
//            //            scrollView.auk.settings.contentMode = UIViewContentMode.scaleAspectFill
//            //
//            //            scrollView.auk.show(url: self.businessDetails.photo)
//
//        }else{
//            print("IMageNotFound")
//        }
//    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupDropDowns() {
        
        setupChooseArticleDropDown()
        setupChooseArticleDropDown2()
       
    }
    
    func dismissKeyboard() {
       
        
                for textField in textFields {
                    textField.resignFirstResponder()
                }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Validate the email field
        if textField == emailTextField {
            validateEmailField()
        }
        
        // When pressing return, move to the next field
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder! {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
           
        }
        return false
    }
    
    @IBAction func validateEmailField() {
        validateEmailTextFieldWithText(email: emailTextField.text)
    }
    
    func validateEmailTextFieldWithText(email: String?) {
        guard let email = email else {
            emailTextField.errorMessage = nil
            return
        }
        
        if email.characters.isEmpty {
            emailTextField.errorMessage = nil
        } else if !validateEmail(candidate: email) {
            emailTextField.errorMessage = NSLocalizedString(
                "Email not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " "
            )
        } else {
            emailTextField.errorMessage = nil
        }
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    func setupUser() {
        
        for textField in textFields {
            applySkyscannerTheme(textField: textField)
        }
    
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        

        textField.titleLabel.font = UIFont(name: "Poppins-Regular", size: 10)
    
    }
    
    @IBAction func categoryMenuAction(_ sender: Any) {
        chooseArticleDropDown.show()
        
      
    }
    
    @IBAction func subCategoryMenuAction(_ sender: Any) {
        chooseArticleDropDown2.show()
    }
    
    
    func subCategoryMenuURL(Ints:Int){
        
        Alamofire.request( urlClass().url1 + "subcategory.php", method: .get,  parameters:["catid": Ints ])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParseForSubCatMenu(response.result.value! as AnyObject)
                //self.stopAnimating()
                case .failure(let error):
                    print("ERRRORR = \(error)")
                    
                    
                }
        }
        
    }
    
    func jsonResultParseForSubCatMenu( _ json:AnyObject){
        
        catMenuBox.removeAll()
        SubCaTMenuNewBox.removeAll()
        SubCaTMenuNewBoxForId.removeAll()
        
        let JSONDict = json as! NSDictionary
        
        let MenuResult = JSONDict.object(forKey: "result") ?? "Not here"
        
        
        
        let JSONArray = MenuResult as! NSArray

        

        if JSONArray.count != 0 {

            for i:Int in 0 ..< JSONArray.count {

                let jobject = JSONArray[i] as! NSDictionary

                let uSubCatMEnus :catMenu = catMenu()
                uSubCatMEnus.id = (jobject.object(forKey: "id") as AnyObject? as? Int)!
                uSubCatMEnus.name = jobject.object(forKey: "name") as AnyObject? as? String ?? ""

                print("uCAtMenu = \(uSubCatMEnus)")
                catMenuBox.append(uSubCatMEnus)

            }

        }

        for i:Int in 0 ..< catMenuBox.count{

            print("SubCAtMenuNames = \(catMenuBox[i].name)")
            print("SubCAtMenuNames = \(catMenuBox[i].id)")
            SubCaTMenuNewBox.append(catMenuBox[i].name)
            SubCaTMenuNewBoxForId.append(catMenuBox[i].id)
           

        }

        setupChooseArticleDropDown2()
    }
    
    func categoryMenuURL(){
        
        Alamofire.request( urlClass().url1 + "category.php", method: .post,  parameters:["": ""])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParseForCatMenu(response.result.value! as AnyObject)
                //self.stopAnimating()
                case .failure(let error):
                    print("ERRRORR = \(error)")
                    
                    
                }
        }
        
    }
    
    func jsonResultParseForCatMenu( _ json:AnyObject){
        
        catMenuBox.removeAll()
        CaTMenuNewBox.removeAll()
        CaTMenuNewBoxForId.removeAll()
        
        let JSONDict = json as! NSDictionary
        
        let MenuResult = JSONDict.object(forKey: "result") ?? "Not here"
        
      
        
        let JSONArray = MenuResult as! NSArray
        
       
        
        if JSONArray.count != 0 {
            
            for i:Int in 0 ..< JSONArray.count {
                
                let jobject = JSONArray[i] as! NSDictionary
                
                let uCatMEnu :catMenu = catMenu()

                uCatMEnu.id = (jobject.object(forKey: "id") as AnyObject? as? Int)!
                uCatMEnu.name = jobject.object(forKey: "name") as AnyObject? as? String ?? ""
                
                print("uCAtMenu = \(uCatMEnu)")
                catMenuBox.append(uCatMEnu)
                
            }
            
        }
        
        for i:Int in 0 ..< catMenuBox.count{
            
            print("CAtMenuNames = \(catMenuBox[i].name)")
            print("CAtMenuNames = \(catMenuBox[i].id)")
            CaTMenuNewBox.append(catMenuBox[i].name)
            CaTMenuNewBoxForId.append(catMenuBox[i].id)
            
        }
        
        setupChooseArticleDropDown()
    }
    
    var catMenuId:Int = 0
    var SubMenuId:Int = 0
    
    func setupChooseArticleDropDown() {
        
        
        chooseArticleDropDown.anchorView = categoryOutlet
        
         chooseArticleDropDown.bottomOffset = CGPoint(x: 0, y: categoryOutlet.bounds.height)
        

        
       print("catMenuNewBox = \(CaTMenuNewBox)")
        print("catMenuNewBoxForId = \(CaTMenuNewBoxForId)")
        
        chooseArticleDropDown.dataSource = CaTMenuNewBox
        self.categoryOutlet.setTitle(CaTMenuNewBox[0], for: .normal)
        self.subCategoryMenuURL(Ints:self.CaTMenuNewBoxForId[0])
       
        chooseArticleDropDown.selectionAction = { [unowned self] (index, item) in
            self.categoryOutlet.setTitle(item, for: .normal)
            
            print("IDNo = \(self.CaTMenuNewBoxForId[index])")
            
            self.catMenuId = self.CaTMenuNewBoxForId[index]
            
            print("CATMenuID = \(self.catMenuId)")
            
            self.subCategoryMenuURL(Ints:self.CaTMenuNewBoxForId[index])

        }
    }
    
    func setupChooseArticleDropDown2() {
        
       
        
        chooseArticleDropDown2.anchorView = subCategoryOutlet
        
        chooseArticleDropDown2.bottomOffset = CGPoint(x: 0, y: subCategoryOutlet.bounds.height)
        

        
        print("SubCatMenuNewBox = \(SubCaTMenuNewBox)")
        print("SubCatMenuNewBoxForId = \(SubCaTMenuNewBoxForId)")
        
        chooseArticleDropDown2.dataSource = SubCaTMenuNewBox
        self.subCategoryOutlet.setTitle(SubCaTMenuNewBox[0], for: .normal)
        
        chooseArticleDropDown2.selectionAction = { [unowned self] (index, item) in
            self.subCategoryOutlet.setTitle(item, for: .normal)
            self.SubMenuId = self.SubCaTMenuNewBoxForId[index]
            print("SubCATMenuID = \(self.SubMenuId)")
        }
        
       
    }
    
    //MARK: Image picking process
    
    @IBAction func pickImageAction(_ sender: Any) {
        
        imageData.removeAll()
        
        
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        
        imagePicker.imageLimit = 3
        
        imagePicker.configuration = config
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)

       
        
        
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
        print("PICKER IS WORKING!!!!")
        
      
        
        guard images.count > 0 else { return }
        
        print("ImageCOunt = \(images.count)")

        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        print("BUttonPressed")
        
        imagePickingInProgress = false
        
        for namesOFImages in images{
            print("NAMESOFIMAGES = \(namesOFImages)")
            scrollView.auk.show(image: namesOFImages)
            
            
        }
        
      //  let chosenImage = images[0]
       // imageBanner.contentMode = UIViewContentMode.scaleAspectFill
      //  imageBanner.clipsToBounds = true
      //  imageBanner.image = chosenImage
        imagePicker.dismiss(animated: true, completion: nil)
        
         for imageDatas in images {
            self.imageData.append(imageDatas)
            print("ImageLoaded")
        
        }
        
    }
    
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
        print("CANceledDPressed")
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    

    
    func UploadRequest(images: UIImage)
    {
    //  self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        
         print("HIT3")
        let parameters = [
            
            "uuid":uservalue,
            "user_id":"uservalue3232323"
        ]

        
        let boundary = generateBoundaryString()
        
        
        
        let url = URL(string: urlClass().url1 + "uploadnew2.php")
        
        let request = NSMutableURLRequest(url: url!)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
       
        
        
        
        let body = NSMutableData()
        
      //  print (" Count = \(PhotoArray.count)")
        
        
        
        
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
       // var i = 0
//        for image in PhotoArray
//        {
            let fname = "test\(i).jpeg"
            let mimetype = "image/jpeg"
            
        let image_data = UIImageJPEGRepresentation(images, 1)
            
            print ("IMAGE = \(String(describing: image_data))")
            
            let boundaryPrefix = "--\(boundary)\r\n"
            
            for (key, value) in parameters {
                body.appendString(string: boundaryPrefix)
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
            
        body.appendString(string: boundaryPrefix)
            
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"uploaded_file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append(image_data!)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
            i += 1
     //   }
        
        
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        request.httpBody = body as Data
        
    
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                 print("HIT4")
                // self.resLab = dataString
                print("DATA = \(dataString)")
                //self.resultLabel.text = dataString as AnyObject as? String
                DispatchQueue.main.async() {
                    print("HIT5")
                    // Do stuff on the UI thread
                    let NEwVale = dataString as String
                    print("NEWVALUE = \(NEwVale)")
                    if NEwVale.isEmpty == false{
                        print("HIT6")
                        self.stopAnimating()
                    self.toCallSuccessPage()
                    }
                    return
                }
                
            }
            
            
            
            
            
        })
        
        
        
        task.resume()
        

        
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
//    func uploadProfileGIF(imageArray: [UIImage]){
//        var count = 0
//        let bucketname = uservalue
//        let uploadUrl = urlClass().url1 + "uploadnew2.php"
//        for i in imageArray{
//            var objectname = "picture" + String(count)
//            let image = i;
//            //Turn image into data
//            let imageData: NSData = UIImageJPEGRepresentation(image, 0.5)! as NSData
//            
//            let params = ["objectname" : objectname, "bucketname" : bucketname, "isGifImgae" : "True", "content_type" : "image/jpeg"]
//            
//            let manager = AFHTTPSessionManager()
//            manager.POST(uploadUrl, parameters: params, constructingBodyWithBlock: { (AFMultipartFormData) in
//                
//                AFMultipartFormData.appendPartWithFileData(imageData, name: "file", fileName: "image", mimeType: "image/jpeg")
//            }, progress: nil, success: { (s:URLSessionDataTask, response) in
//                print(response)
//            }) { (s:URLSessionDataTask?, e:NSError?) in
//                print(e)
//            }
//            count+=1
//        }
//        
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//
//        imageBanner.contentMode = UIViewContentMode.scaleAspectFill
//        imageBanner.clipsToBounds = true
//        imageBanner.image = chosenImage
//        // use the image
//        dismiss(animated: true, completion: nil)
//    }
//
//
//
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//
    
    
    @IBAction func openingTime(_ sender: Any) {
        
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        
        openTime = timeFormat.string(from: openingTime.date)
        print("opentingTime = \(openTime)")
 
    }
    
    @IBAction func closingTime(_ sender: Any) {
        
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        
        closeTime = timeFormat.string(from: closingTime.date)
        print("ClosingTime = \(closeTime)")
        
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
                
                //                openURL:options:completionHandler:
              //  UIApplication.shared.canOpenURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                
                
            }))
            
            alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            self.present(alertControllerz, animated: true, completion: nil)
        }else{
            
            
            if placemark != nil {
                //stop updating location to save battery life
             //   locationManager.stopUpdatingLocation()
                
                if let currLoc = locationManager.location{
                    currentLocation = currLoc
                    
                    Mylocations.latitude = "\(currentLocation.coordinate.latitude)"
                    
                    Mylocations.longitude = "\(currentLocation.coordinate.longitude)"
                    
                    
                }
                
                
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    
    @IBAction func PlacePickerAction(_ sender: Any) {
        
        

            if CLLocationManager.authorizationStatus() == .denied{

                let alertControllerz = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "This application requires location services to work. Do you want to enable location from settings?", preferredStyle: UIAlertControllerStyle.alert)

                alertControllerz.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in

                    UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)

                    //                openURL:options:completionHandler:
                    //  UIApplication.shared.canOpenURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)


                }))

                alertControllerz.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action: UIAlertAction!) in
                }))

                self.present(alertControllerz, animated: true, completion: nil)
            
        }else{
                
                
                if Mylocations.latitude.isEmpty && Mylocations.latitude.isEmpty {
                    locationManager.startUpdatingLocation()
                    
                    let alert = UIAlertView(title: OSConstants.APPLICATION_NAME(), message: "Location not found!!.Please try again", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }else{
                    
                let center = CLLocationCoordinate2D(latitude: Double(Mylocations.latitude)!, longitude: Double(Mylocations.longitude)!)
                let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
                let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
                let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
                let config = GMSPlacePickerConfig(viewport: viewport)
        
       
                    let placePicker = GMSPlacePickerViewController(config: config)
        
                    placePicker.delegate = self
                    placePicker.modalPresentationStyle = .popover
                    placePicker.popoverPresentationController?.sourceView = addLocationOutlet
                    placePicker.popoverPresentationController?.sourceRect = addLocationOutlet.bounds
        
                    present(placePicker, animated: true, completion: nil)
        

        }
        }
    }
    
  
    
   
    
    // MARK: - Validating the fields when "submit" is pressed
    
    var isSubmitButtonPressed: Bool = false
    
    var showingTitleInProgress: Bool = false
    
    var imagePickingInProgress: Bool = true
    
    
   
    @IBAction func submitAction(_ sender: Any) {
        
        let catTitle = self.categoryOutlet.titleLabel?.text
        let subCatTitle = self.subCategoryOutlet.titleLabel?.text
        
        print("categoryOutletTitle = \(String(describing: catTitle))")
        print("SubCategoryOutletTitle = \(String(describing: subCatTitle))")
        print("categoryID = \(catMenuId)")
        print("SubCategoryID = \(SubMenuId)")
       
        print("openTime = \(openTime.isEmpty ? "00:00":openTime)")
        print("closeTime = \(closeTime.isEmpty ? "00:00":closeTime)")
        
        let OTime = openTime.isEmpty ? "00:00":openTime
        let CTime = closeTime.isEmpty ? "00:00":closeTime
        
        for textField in textFields {
            textField.resignFirstResponder()
            textField.isHighlighted = false
        }
        
        print("FirstTextField = \(textFields[0].text!)")
        
        
       
        
        //self.isSubmitButtonPressed = true
        showingTitleInProgress = false
        
        for textField in textFields where !textField.hasText {
            
            showingTitleInProgress = true
            textField.setTitleVisible(
                true,
                animated: true
              
            )

            textField.isHighlighted = true
        }
        
        if emailTextField.errorMessage != nil{
            showingTitleInProgress = true
        }
        
        if !showingTitleInProgress{
        
        if locationInProgress == true {
            let alert = UIAlertController(title: "Alert", message: "Select your preffered location", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
      }
        
       
        if !locationInProgress{
            if imagePickingInProgress == true {
                let alert = UIAlertController(title: "Alert", message: "Please pick Images", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        if !showingTitleInProgress && !locationInProgress && !imagePickingInProgress {
            
            hideTitleVisibleFromFields()
            
            print("categoryOutletTitle = \(String(describing: catTitle))")
            print("SubCategoryOutletTitle = \(String(describing: subCatTitle))")
            print("categoryID = \(catMenuId)")
            print("SubCategoryID = \(SubMenuId)")
            
            self.params = [
                
                "uuid":uservalue,
                "cat_id":String(catMenuId),
                "subcat_id":String(SubMenuId),
                "category":catTitle!,
                "sub_category":subCatTitle!,
                "title":textFields[0].text!,
                "description":textFields[1].text!,
                "user_mobile":textFields[8].text!,
                "user_email":textFields[7].text!,
                "door_no":textFields[2].text!,
                "street":textFields[3].text!,
                "city":textFields[4].text!,
                "state":textFields[5].text!,
                "pincode":textFields[6].text!,
                "location":SelectedPlaceInfo[1] + "," + SelectedPlaceInfo[2],
                "opens_at":OTime,
                "closed_at":CTime,
                "user_website":textFields[9].text!,
                "admin_username":"JOK",
                "qr_code":"asd34234",
                "terms1":"sadfasdfasd",
                "terms2":"asdfasdfasdf",
                "terms3":"asdfasdfasdf"
            ]
            
            callUrlFunc()
            
            
            
           

        }
        
    }
    
    func hideTitleVisibleFromFields() {
        
        for textField in textFields {
            textField.setTitleVisible(false, animated: true)
            textField.isHighlighted = false
        }
        
    }
    
    func callUrlFunc(){
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "user_business_postdata2.php", method: .get,  parameters:self.params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    
                    UserDefaults.standard.set(phoneVarBox.phoneNum, forKey: "PhoneNum")
                    
                case .failure(let error):
                    print("ERRRORR = \(error)")
                    self.stopAnimating()
                    
                    
                }
        }
        
    }
    
    func jsonResultParse( _ json:AnyObject){
        
        print("HIT1")
        let JSONArray = json as! NSDictionary
        
        let Response = JSONArray.object(forKey: "success") ?? "Not here"
        
        print("Response = \(Response)")
        
        
        for imageDatas in imageData {
             print("HIT2")
            UploadRequest(images: imageDatas)
        }
        
       
        
        
    }
    
    func toCallSuccessPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SuccessPageViewController") as! SuccessPageViewController
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
  
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension PostBusinessFormViewController :GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
// GMSPlacePickerViewControllerDelegate and implement this code.
func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
  // Dismiss the place picker, as it cannot dismiss itself.
  viewController.dismiss(animated: true, completion: nil)
   SelectedPlaceInfo = [place.name, String(place.coordinate.latitude ), String(place.coordinate.longitude) ]
    if place.formattedAddress == nil {
        print("Address not found")
        SelectedPlaceInfo.append("Address not found")
    }else{
       print("Address = \(place.formattedAddress!)")
       SelectedPlaceInfo.append(place.formattedAddress!)
    }
    
    
    
    
    
    
 locationInProgress  = false
  print("Place name \(SelectedPlaceInfo[0])")
    print("PlaceCLati \(SelectedPlaceInfo[1])")
    print("PlaceCLong = \(SelectedPlaceInfo[2])")
   print("PlaceAddress = \(SelectedPlaceInfo[3])")
}

func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
  // Dismiss the place picker, as it cannot dismiss itself.
  viewController.dismiss(animated: true, completion: nil)

  print("No place selected")
}
    
  
}


