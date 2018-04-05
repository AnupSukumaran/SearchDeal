//
//  OTPViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 01/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire

class OTPViewController: UIViewController {
    
     var passedValue: String?
    
    var loginCheck = ""

    @IBOutlet weak var phoneNoLabel: UILabel!
    
    @IBOutlet weak var otpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpTextField.keyboardType = UIKeyboardType.numberPad
        otpTextField.setBottomBorder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

        if let phoneNO = passedValue{
            
            phoneNoLabel.text = phoneNO
        }
        
      
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        otpTextField.resignFirstResponder()
    }
    
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func PassingOTPAction(_ sender: Any) {
        
        print("Passing OTP....")
        
        let parameters = [
            "mobile": phoneNoLabel.text!,
            "otp": otpTextField.text!
        ]
        
        Alamofire.request( urlClass().url4 , method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                // self.stopAnimating()
                case .failure(let error):
                    print(error)
                    //   self.stopAnimating()
                    // return userCatagory
                }
                
                
        }
    }
    
    func jsonResultParse( _ json:AnyObject){
        
        
        
        let JSONArray = json as! NSDictionary
        
        
        let message = (JSONArray["message"] as AnyObject? as? String) ?? ""
        
        if message.isEmpty{
            print("Wrong OTP")
            dismiss(animated: true, completion: nil)
            
            
        }else{
        print("Message123 = \(message)")
            
            UserDefaults.standard.set(message, forKey: "Login")
            UserDefaults.standard.set(passedValue, forKey: "PhoneBeforeSubmit")
          
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MerchantMainViewController") as! MerchantMainViewController
            
            let navController = UINavigationController(rootViewController: vc)
            
            
            self.present(navController, animated:true, completion: nil)
            
        }
        
        
        
    }

    @IBAction func editBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //http://searchdeal.co.in/business-profile/digital/verify_otp.php?mobile=9633361469&otp=4504
    
}
