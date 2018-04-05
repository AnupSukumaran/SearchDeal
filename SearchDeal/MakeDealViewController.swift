//
//  MakeDealViewController.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 15/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
class MakeDealViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate,NVActivityIndicatorViewable{

    
    @IBOutlet var buttonBack: UIButton!
    
    @IBOutlet var textFName: UITextField!
    
    @IBOutlet var textEmail: UITextField!
    
    @IBOutlet var textPhone: UITextField!
    
    @IBOutlet var testWhatUWant: UITextView!
    
    var name:String = ""
    var email:String = ""
    var phone:String = ""
    var whatuwant:String = ""
    
    var randomid:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textFName.delegate = self
        self.textEmail.delegate = self
        self.textPhone.delegate = self
        self.testWhatUWant.delegate = self
        
        testWhatUWant.text="What you want?"
        testWhatUWant.textColor = UIColor.lightGray
        
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFName.resignFirstResponder()
        textEmail.resignFirstResponder()
        textPhone.resignFirstResponder()
        self.testWhatUWant.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard(){
        
        textFName.resignFirstResponder()
        textEmail.resignFirstResponder()
        textPhone.resignFirstResponder()
        self.testWhatUWant.resignFirstResponder()
        
        
    }

    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        testWhatUWant.text=""
        testWhatUWant.textColor = UIColor.black
       
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if (textView.text.characters.count == 0) {
            
            testWhatUWant.text="What you want?"
            testWhatUWant.textColor = UIColor.lightGray
            testWhatUWant.resignFirstResponder()
          
        }

       
    }
    
    
    
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
    
    }

    
    
    @IBAction func actionBack(_ sender: AnyObject) {
 
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func actionSendMakeDeal(_ sender: AnyObject) {
       
        self.name = (self.textFName.text?.trimmingCharacters(in: CharacterSet.whitespaces))!
         self.email = (self.textEmail.text?.trimmingCharacters(in: CharacterSet.whitespaces))!
         self.phone = (self.textPhone.text?.trimmingCharacters(in: CharacterSet.whitespaces))!
         self.whatuwant = (self.testWhatUWant.text?.trimmingCharacters(in: CharacterSet.whitespaces))!
        
        if self.name != ""{
        
            if Utilities.isValidEmail(testStr: self.email){
            
                if Utilities.isValidMobile(mobile: self.phone as NSString){
                    
                    if self.whatuwant != ""{
                    
                        self.funcMakeDeal()
                        
                    }
                    else{
                         funcAlert("Message is empty")
                    }
                
                }
                else{
                    funcAlert("Invalid phone")
                }
            
            }
            else{
                funcAlert("Invalid email")
            }
        }
        else{
            funcAlert("Name is empty")
        }
    
    }
    
    
    
    
    func funcMakeDeal(){
        
        let params = [
            "email":self.email,
            "fname":self.name,
            "mobile":self.phone,
            "message":self.whatuwant,
            "randomid":self.randomid
        ]
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        
        Alamofire.request("http://searchdeal.co.in/business-ios/dealenquiry.php", method: .get, parameters: params)
            .validate()
            .responseString { response in
                print (response.result.value)
                
                let ss:AnyObject = response.result.value! as AnyObject
                
                let RESULT:String = String(describing: ss)
                
                print("RESULT  : ",RESULT)
                switch response.result {
                case .success:
                    print("Validation Successful")
                    
                    debugPrint(response.result.value)
                    
                    
                    if RESULT == "1"{
                        
                        self.funcAlert("Successfully Sent")
                        
                        self.textFName.text=""
                        self.textEmail.text=""
                        self.textPhone.text=""
                        self.testWhatUWant.text=""

                    }
                    else{
                        
                        self.funcAlert("Sending Failed")
                        
                    }
                    
                    
                    
                case .failure(let error):
                    print(error)
                    // return userCatagory
                }
                
                self.stopAnimating()
                
        }
    
    }
    
    func funcAlert( _ msg:String){
        
        let alert = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        
        self.present(alert, animated: true, completion: nil)
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            
            alert.dismiss(animated: true, completion: nil)
        })
    }

    
    
    
}
