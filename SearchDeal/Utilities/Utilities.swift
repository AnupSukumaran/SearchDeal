//
//  Utilities.swift
//  Carbon Kit Swift
//
//  Created by Quiqinfotech Capitan on 06/03/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import Foundation
import UIKit

public class Utilities
{
    
    
    
    
    public func randomStringWithTimeStamp (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return ((randomString as String)+self.createTimeStamp()+".jpg") as NSString
    }
    
    
    
    
    
    /*----------------------- Create Random Number between 1000 and 9999 --------------------------*/
    
    public func createRandomNumber()->String{
        
        
        let diceRoll = (arc4random() % 1000) + 8999;
        
        
        
        return String(diceRoll)
    }
    
    
    
    
    /*----------------------- Custom Date Formatting --------------------------*/
    
    public func stringFromDate(date: NSDate,dateToFormat:String) -> String
        
    {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateToFormat
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
        
    }
    
    /*-----------------------------------------------------------------------*/
    
    /*----------------------- Custom Date Formatting --------------------------*/
    
    public func dateFromString(dateToFormat:String) -> NSDate
    {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateToFormat
        
        let dateString = dayTimePeriodFormatter.date(from: dateToFormat)
        
        return dateString! as NSDate
        
    }
    
    
    
    /*----------------------- Custom Date Formatting --------------------------*/
    
    public func stringDateFromString(date: String,dateCurrentFormat:String,dateToFormat:String) -> String
        
    {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateCurrentFormat
        
        let dateString = dayTimePeriodFormatter.date(from: date)
        
        
        
        let dayTimePeriodFormatterNew = DateFormatter()
        dayTimePeriodFormatterNew.dateFormat = dateToFormat
        
        let dateStringNew = dayTimePeriodFormatterNew.string(from: dateString!)
        
        return dateStringNew
        
    }
    
    /*-----------------------------------------------------------------------*/
    
    
    
    /*
     var dateString = "2014-07-15" // change to your date format
     
     var dateFormatter = NSDateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd"
     
     var date = dateFormatter.dateFromString(dateString)
     println(date)
     
     */
    
    
    
    
    /*----------------------- Email Validation Test --------------------------*/
    
    class func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    
    
    /*----------------------- Create round image --------------------------*/
    
    
    class func createRoundedImage(image: UIImageView) -> UIImageView {
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
        return image
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    /*----------------------- Create round image --------------------------*/
    
    
    class func createRoundedCornerImage(image: UIImageView,cornerRadi:CGFloat) -> UIImageView {
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = cornerRadi
        image.clipsToBounds = true
        
        return image
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    
    
    /*-------------------- Mobile Number Validation Test ----------------------*/
    
    
    
    class func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    /*-------------------- Pincode  Validation Test ----------------------*/
    
    
    
    class func isValidPincode(Pincode: NSString) -> Bool {
        
        var isValidPIN: Bool = false
        if Pincode.length == 6 && Pincode.rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789") as CharacterSet).location != NSNotFound {
            
            isValidPIN = true
        }
        
        return isValidPIN
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    /*-------------------- Password Validation  Test ----------------------*/
    
    
    class func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }
        else{
            return false
        }
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    
    
    /*-------------------- Password Length Validation Test ----------------------*/
    
    class func isPasswordLenth(password: String , confirmPassword : String) -> Bool {
        if password.characters.count <= 7 && confirmPassword.characters.count <= 7{
            return true
        }
        else{
            return false
        }
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    /*-------------------- Name Validation Test ----------------------*/
    
    
    
    class func isValidName(firstName: NSString) -> Bool {
        
        var isValidFirstName: Bool = false
        var characterSet: NSCharacterSet = NSCharacterSet.letters as NSCharacterSet
        characterSet = characterSet.inverted as NSCharacterSet
        if firstName.length >= 3 && firstName.length <= 20 {
            
            let r: NSRange = firstName.rangeOfCharacter(from: characterSet as CharacterSet)
            if r.location != NSNotFound {
                
                isValidFirstName = false
            }
            else {
                
                isValidFirstName = true
            }
        }
        else {
            
            isValidFirstName = false
        }
        
        return isValidFirstName
    }
    
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    /*-------------------- Name Validation Test ----------------------*/
    
    
    
    class func isValidLastName(firstName: NSString) -> Bool {
        
        var isValidFirstName: Bool = false
        var characterSet: NSCharacterSet = NSCharacterSet.letters as NSCharacterSet
        characterSet = characterSet.inverted as NSCharacterSet
        if firstName.length > 0 && firstName.length <= 20 {
            
            let r: NSRange = firstName.rangeOfCharacter(from: characterSet as CharacterSet)
            if r.location != NSNotFound {
                
                isValidFirstName = false
            }
            else {
                
                isValidFirstName = true
            }
        }
        else {
            
            isValidFirstName = false
        }
        
        return isValidFirstName
    }
    
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    /*-------------------- First Name Validation Test ----------------------*/
    
    
    
    
    class func validateFirstName(firstName: NSString) -> String {
        
        var isValidFirstName: String = ""
        var characterSet: NSCharacterSet = NSCharacterSet.letters as NSCharacterSet
        characterSet = characterSet.inverted as NSCharacterSet
        if firstName.length >= 3 && firstName.length <= 20 {
            
            let r: NSRange = firstName.rangeOfCharacter(from: characterSet as CharacterSet)
            if r.location != NSNotFound {
                
                isValidFirstName = "Please avoid using special character"
            }
        }
        else {
            
            isValidFirstName = "First Name should be between 3 to 20 letters"
        }
        
        return isValidFirstName
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    /*-------------------- Mobile Number Validation Test ----------------------*/
    
    
    
    class func isValidMobile(mobile: NSString) -> Bool {
        
        var isValidMobile: Bool = false
        if mobile.length == 10 && mobile.rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789") as CharacterSet).location != NSNotFound {
            
            isValidMobile = true
        }
        
        return isValidMobile
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    

    
    
    /*-------------------- Last Name Validation Test ----------------------*/
    
    
    
    
    class func validateLastName(firstName: NSString) -> String {
        
        var isValidFirstName: String = ""
        var characterSet: NSCharacterSet = NSCharacterSet.letters as NSCharacterSet
        characterSet = characterSet.inverted as NSCharacterSet
        if firstName.length > 0 && firstName.length <= 20 {
            
            let r: NSRange = firstName.rangeOfCharacter(from: characterSet as CharacterSet)
            if r.location != NSNotFound {
                
                isValidFirstName = "Please avoid using special character"
            }
        }
        else {
            
            isValidFirstName = "Last Name should be mininum one letter"
        }
        
        return isValidFirstName
    }
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    /*--------------------Application Primary Color ----------------------*/
    
    
    class func appBGColor() -> UIColor{
        
        
        return UIColor(red: 32/255, green: 169/255, blue: 222/255, alpha: 1)
        
    }
    
    /*-----------------------------------------------------------------------*/
    
    
    
    /*-------------------- Password Validation Test ----------------------*/
    
    
    
    class func isValidPassword(firstName: NSString) -> Bool {
        
        var isValidFirstName: Bool = false
        
        if firstName.length >= 5 && firstName.length <= 20 {
            
            
            isValidFirstName = true
            
        }
        else {
            
            isValidFirstName = false
        }
        
        return isValidFirstName
    }
    
    
    
    /*-----------------------------------------------------------------------*/
    
    
    
    
    
    
    /*-------------------- Random String Creation ----------------------*/
    
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return  ((randomString as String)+self.createTimeStamp()) as NSString
    }
    
    
    
    
    class func showToast( obj:AnyObject, title:String, message:String, length:Double)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        obj.present(alert, animated: true, completion: nil)
        let delay = length * Double(NSEC_PER_SEC)
        
        let time = DispatchTime.now() + delay 
        DispatchQueue.main.asyncAfter(deadline: time) {
            alert.dismiss(animated: true, completion: nil)
        }
        
//        let time = DispatchTime.now(dispatch_time_t(DispatchTime.now()), Int64(delay))
//        dispatch_after(time, DispatchQueue.main, {
//            alert.dismiss(animated: true, completion: nil)
//        })
    }
    
    
    
    /*-------------------- Create body with parameter for Image uploading multipart ----------------------*/
    
    public func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String,filename: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        
        
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    /*-------------------- Create Boundary string for Image uploading multipart ----------------------*/
    
    
    public func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
    
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showOSActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0x000000, alpha: 0.4)
        
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideOSActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        uiView.removeFromSuperview()
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    
    
    
    
    
    public func createTimeStamp() -> String {
        
        let date = NSDate()
        let calendar = NSCalendar.current
        let component_year = calendar.component(.year, from: date as Date)
        let component_month = calendar.component(.month, from: date as Date)
        let component_day = calendar.component(.day, from: date as Date)
        let component_hour = calendar.component(.hour, from: date as Date)
        let component_min = calendar.component(.minute, from: date as Date)
        let component_sec = calendar.component(.second, from: date as Date)
        
        var dd:String   = String(component_day)
        var MM:String   = String(component_month)
        let yyyy:String = String(component_year)
        var hh:String   = String(component_hour)
        var mm:String   = String(component_min)
        var ss:String   = String(component_sec)
        
        if dd.characters.count < 2
        {
            dd = "0"+dd
        }
        if MM.characters.count < 2
        {
            MM = "0"+MM
        }
        if hh.characters.count < 2
        {
            hh = "0"+hh
        }
        if mm.characters.count < 2
        {
            mm = "0"+mm
        }
        if ss.characters.count < 2
        {
            ss = "0"+ss
        }
        
        return dd+MM+yyyy+hh+mm+ss
    }
    
    
    
//    class func Notification(var title:String,var messege:String,var image:UIImage?,var backgroundColor:UIColor,var duration:NSTimeInterval?){
//        
//        let banner = Banner(title: title, subtitle: messege, image: image, backgroundColor: backgroundColor)
//        banner.dismissesOnTap = true
//        banner.show(duration: duration)
//    }
    
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
