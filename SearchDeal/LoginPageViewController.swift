//
//  LoginPageViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 30/08/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire

class LoginPageViewController: UIViewController{

    @IBOutlet weak var phoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumber.keyboardType  = UIKeyboardType.phonePad
        phoneNumber.setBottomBorder()
        //phoneNumber.inputAccessoryView.done
        //self.phoneNumber.delegate = self
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   

    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }

func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    phoneNumber.resignFirstResponder()
}
    
   
    
    @IBAction func loginPageButton(_ sender: Any) {
        
        let new:Bool = validate(value: phoneNumber.text!)
      
        if (phoneNumber.text?.isEmpty)!{
            
            print("please enter text!")
            
        }else{
            
            if new == true{
                print("Validated")
                
                
                
                let parameters = [
                    "mobile": phoneNumber.text!,
                    "name": "Anup"
                ]
                
                Alamofire.request( urlClass().url3 , method: .post, parameters: parameters)
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
            }else{
                print("Incorrect Format")
            }

        }
        
        
    }
    
    func jsonResultParse( _ json:AnyObject){
        
        

        let JSONArray = json as! NSDictionary
        
        
            let message = (JSONArray["message"] as AnyObject? as? String) ?? ""
              
        
            print("Message123 = \(message)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.passedValue = phoneNumber.text
        self.present(vc, animated:true, completion: nil)
            
        }
        
    
    
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
