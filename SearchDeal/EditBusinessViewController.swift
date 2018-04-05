//
//  EditBusinessViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 13/10/17.
//

import UIKit
import GooglePlacePicker
import CoreLocation
import SkyFloatingLabelTextField
import ImagePicker
import Kingfisher
import Alamofire
import NVActivityIndicatorView
import Auk
import moa


class EditBusinessViewController: UIViewController,UITextFieldDelegate, ImagePickerDelegate,CLLocationManagerDelegate, NVActivityIndicatorViewable,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var opeingTime: UIDatePicker!
    
    @IBOutlet weak var closingTime: UIDatePicker!
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    @IBOutlet weak var addLocationOutlet: UIButton!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    @IBOutlet weak var businessTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var descriptionTextField: SkyFloatingLabelTextField!
    
    var businessDetails: BusinessProfileModel = BusinessProfileModel()
    
    @IBOutlet weak var doorNoTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var streetTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var pinCodeTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var websiteTextField: SkyFloatingLabelTextField!
    
    let uservalue = UserDefaults.standard.object(forKey: "userUniqueId") as! String
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var currentLocation = CLLocation()
    
    let locationManager = CLLocationManager()
    
     var Mylocations:locationMode = locationMode()
    
     let imagePicker = ImagePickerController()
    
    var textFields: [SkyFloatingLabelTextField] = []
    var imageData:[UIImage] = []
    var SelectedPlaceInfo = [String]()
    
    var closeTime = ""
    var openTime = ""
    
    var params = [String: String]()

    
    var locationInProgress: Bool = true
    var NewImagesPicked: Bool = false
    
    //MARK: View Will load Method
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
       
        
        
    }
    
    //MARK: View Did load Method

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
        

        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        
        let opTime = businessDetails.opens_at
        let clTime = businessDetails.closed_at
        
        print("opentingTime = \(openTime)")
        
        print("OpenAT = \(businessDetails.opens_at)")
         print("CloseAT = \(businessDetails.closed_at)")
        

        
        opeingTime.date = timeFormat.date(from: opTime)!
        openTime = businessDetails.opens_at
        
        closingTime.date = timeFormat.date(from: clTime)!
        closeTime = businessDetails.closed_at

        
        // *MARK -  Dismiss keyboard with touching the background
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        

        
        
        categoryLabel.text = businessDetails.category
        subCategoryLabel.text = businessDetails.sub_category
        businessTextField.text = businessDetails.title
        descriptionTextField.text = businessDetails.description
        doorNoTextField.text = businessDetails.door_no
        streetTextField.text = businessDetails.street
        cityTextField.text = businessDetails.city
        stateTextField.text = businessDetails.state
        pinCodeTextField.text = businessDetails.pincode
        emailTextField.text = businessDetails.user_email
        phoneTextField.text = businessDetails.user_mobile
        websiteTextField.text = businessDetails.user_website
        Mylocations.latitude = businessDetails.latitude
        Mylocations.longitude = businessDetails.longitude

//         let imgUrl = URL(string: self.businessDetails.photo)
//        imageBanner.kf.setImage(with: imgUrl, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        activityIndicator.stopAnimating()
        scrollView.delegate = self
        showInitialImage()
        
        
    }
    
    
    //MARK: AUK Implented Intial Image setup
    private func showInitialImage() {
        
        self.activityIndicator.startAnimating()
        
         scrollView.auk.settings.contentMode = UIViewContentMode.scaleAspectFill
        
        
        if !self.businessDetails.photo.isEmpty {
            
          // scrollView.auk.removeAll()
            let imgUrl = URL(string: self.businessDetails.photo)
            DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
                let fetch = NSData(contentsOf: imgUrl! as URL)
                // print("HIT1")
                DispatchQueue.main.async {
                    if let imageData = fetch  {
                        self.activityIndicator.stopAnimating()
                       let imageForm = UIImage(data: imageData as Data)
                        self.scrollView.auk.settings.pageControl.backgroundColor = UIColor.purple.withAlphaComponent(0.3)
                        self.scrollView.auk.show(image: imageForm!)
                        
                    }
                }
                
            }
            
//            print("IMAGEURL123 = \(businessDetails.photo)")
//
//            scrollView.auk.settings.contentMode = UIViewContentMode.scaleAspectFill
//
//            scrollView.auk.show(url: self.businessDetails.photo)
            
        }else{
            print("IMageNotFound")
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: funcs to dismiss keyboard
    
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
    
    // MARK: funcs to Vadidate emailTextField.text
    
    
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
    
    @IBAction func OpeningTimeAction(_ sender: Any) {
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        print("FORMAT = \(opeingTime.date)")
        openTime = timeFormat.string(from: opeingTime.date)
        print("opentingTime = \(openTime)")
    }
    
    
    @IBAction func CloseTimeAction(_ sender: Any) {
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
                
                let alert = UIAlertView(title: OSConstants.APPLICATION_NAME(), message: "Location not found.Please try again", delegate: nil, cancelButtonTitle: "OK")
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
    
    
    // MARK: Image picking process
    
    @IBAction func imagePicker(_ sender: Any) {
        
        NewImagesPicked = true
        
        
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        
        imagePicker.imageLimit = 3
        
        imagePicker.configuration = config
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        
        print("ImageCOunt = \(images.count)")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("BUttonPressed")
        
        imageData.removeAll()
        scrollView.auk.removeAll()
        
        for namesOFImages in images{
            print("NAMESOFIMAGES = \(namesOFImages)")
             scrollView.auk.show(image: namesOFImages)
            
            
        }
        
//        let chosenImage = images[0]
//        imageBanner.contentMode = UIViewContentMode.scaleAspectFill
//        imageBanner.clipsToBounds = true
//        imageBanner.image = chosenImage
        imagePicker.dismiss(animated: true, completion: nil)
        
        for imageDatas in images {
            self.imageData.append(imageDatas)
            print("ImageLoaded")
            
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
         imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Validating the fields when "submit" is pressed
    
    var isSubmitButtonPressed: Bool = false
    
    var showingTitleInProgress: Bool = false
    
    @IBAction func submitAction(_ sender: Any) {
        
        print("Submit")
        
        let OTime = openTime.isEmpty ? "00:00":openTime
        let CTime = closeTime.isEmpty ? "00:00":closeTime
        
        
        
        for textField in textFields {
            textField.resignFirstResponder()
            textField.isHighlighted = false
        }
        
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
            
            if Mylocations.latitude.isEmpty && Mylocations.latitude.isEmpty {
                let alert = UIAlertController(title: "Alert", message: "Select your preffered location", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                
//                SelectedPlaceInfo[1] = Mylocations.latitude
//                SelectedPlaceInfo[2] = Mylocations.longitude
                
                
//                let locationLat = SelectedPlaceInfo[1].isEmpty ? Mylocations.latitude : SelectedPlaceInfo[1]
//                let locationLong = SelectedPlaceInfo[2].isEmpty ? Mylocations.longitude : SelectedPlaceInfo[2]
//                SelectedPlaceInfo.insert(Mylocations.latitude, at: 1)
//                SelectedPlaceInfo.insert(Mylocations.longitude, at: 2)
                
                hideTitleVisibleFromFields()
                
                self.params = [
                    
                    "uuid":uservalue,
                    "cat_id":String(businessDetails.cat_id),
                    "subcat_id":String(businessDetails.subcat_id),
                    "category":businessDetails.category,
                    "sub_category":businessDetails.sub_category,
                    "title":textFields[0].text!,
                    "description":textFields[1].text!,
                    "user_mobile":textFields[8].text!,
                    "user_email":textFields[7].text!,
                    "door_no":textFields[2].text!,
                    "street":textFields[3].text!,
                    "city":textFields[4].text!,
                    "state":textFields[5].text!,
                    "pincode":textFields[6].text!,
                    "location":Mylocations.latitude + "," + Mylocations.longitude,
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
        
//        if !showingTitleInProgress && !locationInProgress {
//
//            hideTitleVisibleFromFields()
//
//            self.params = [
//
//                "uuid":uservalue,
//                "cat_id":String(businessDetails.cat_id),
//                "subcat_id":String(businessDetails.subcat_id),
//                "category":businessDetails.category,
//                "sub_category":businessDetails.sub_category,
//                "title":textFields[0].text!,
//                "description":textFields[1].text!,
//                "user_mobile":textFields[8].text!,
//                "user_email":textFields[7].text!,
//                "door_no":textFields[2].text!,
//                "street":textFields[3].text!,
//                "city":textFields[4].text!,
//                "state":textFields[5].text!,
//                "pincode":textFields[6].text!,
//                "location":SelectedPlaceInfo[1] + "," + SelectedPlaceInfo[2],
//                "opens_at":OTime,
//                "closed_at":CTime,
//                "user_website":textFields[9].text!,
//                "admin_username":"JOK",
//                "qr_code":"asd34234",
//                "terms1":"sadfasdfasd",
//                "terms2":"asdfasdfasdf",
//                "terms3":"asdfasdfasdf"
//            ]
//
//            callUrlFunc()
//
//
//
//
//
//        }
        
        
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
        
        if NewImagesPicked == true {
            for imageDatas in imageData {
                print("HIT2")
                UploadRequest(images: imageDatas)
            }
        }else{
            self.stopAnimating()
            toCallSuccessPage()
        }
        
    }
    
     var i:Int = 0
    
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
    
    
    func toCallSuccessPage(){
        dismiss(animated: true, completion: nil)
    }
    
    

}

extension EditBusinessViewController :GMSPlacePickerViewControllerDelegate {
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
        
        
        Mylocations.latitude =  String(place.coordinate.latitude )
        Mylocations.longitude = String(place.coordinate.longitude)
        
        
        
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

