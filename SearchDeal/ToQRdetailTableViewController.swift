//
//  ToQRdetailTableViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 21/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import Kingfisher

protocol DataIndicationDelegate: class {
    func DataIndicate(value: Bool)
}

class ToQRdetailTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
     var locations:locationMode = locationMode()
    
    var SubcatMaster:SubCatagoryMasterList = SubCatagoryMasterList()
    
    var qrcode = ""
    
    weak var delegate: DataIndicationDelegate?
    
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var businessLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var diatanceLabel: UILabel!
    
    @IBOutlet weak var reachesLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var webTextView: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    var Imeino = UserDefaults.standard.object(forKey: "userUniqueId") as! String
     var params = [String:String]()
    
   // @IBOutlet weak var textHeightConstrains: NSLayoutConstraint!
    
    @IBOutlet weak var textViewsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var dataindication:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("QRCODE2 = \(qrcode)")
        print("lat2 = \(locations.latitude)")
        print("longi2 = \(locations.longitude)")
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "business_code.php?", method: .post, parameters: ["qrcode": qrcode,"lat": locations.latitude, "long": locations.longitude])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    self.stopAnimating()
                    self.dataIndicationResponse(DataIn: true)
                    
                case .failure(let error):
                    print("ERROR = \(error)")
                    self.stopAnimating()
                    self.dataIndicationResponse(DataIn: false)
                    
                    
                    
                }
                
        }

    }
    
    func dataIndicationResponse(DataIn:Bool){
        
        delegate?.DataIndicate(value: DataIn)
        
    }
    
    
    @IBAction func likeButton(_ sender: Any) {
        
        likeButton.setImage(UIImage(named: "yellowHeart"), for: UIControlState.normal)
        
        
        self.params = [
            "pid":SubcatMaster.randomid,
            "imeino":Imeino,
            "catid":SubcatMaster.cat_id,
            "subid":SubcatMaster.subcat_id
            
        ]
        
        let URLs = urlClass().url1 + "user_like.php?"
        
        
        
        Alamofire.request( URLs, method: .get,  parameters:self.params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse2(response.result.value! as AnyObject)
                    
                case .failure(let error):
                    print("ERRRORR = \(error)")
                    // return userCatagory
                }
        }
        
        
    }
    
    func jsonResultParse2( _ json:AnyObject){
        
        let JSONArray = json as! NSDictionary
        
        let test = JSONArray.object(forKey: "success")
        print("RESPONELIke = \(String(describing: test)) ")
        
        //        for i:Int in 0 ..< JSONArray.count  {
        //
        //            let jObject = JSONArray[i] as! NSDictionary
        //            print("RESPONELIke = \(jObject) ")
        //
        //        }
        
    }
    
    
     func jsonResultParse( _ json:AnyObject){
        
        
        
        let JSONArray = json as! NSArray
        
        print("JSON COUNT ",JSONArray.count)
        
        if JSONArray.count != 0 {
            
            
            for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
               
                
                SubcatMaster.category1 = (jObject["category1"] as AnyObject? as? String) ?? ""
                SubcatMaster.category2 = (jObject["category2"] as AnyObject? as? String) ?? ""
                SubcatMaster.ccode = (jObject["ccode"] as AnyObject? as? String) ?? ""
                SubcatMaster.city = (jObject["city"] as AnyObject? as? String) ?? ""
                
                SubcatMaster.company = (jObject["company"] as AnyObject? as? String) ?? ""
                SubcatMaster.country = (jObject["country"] as AnyObject? as? String) ?? ""
                SubcatMaster.dealstatus = (jObject["dealstatus"] as AnyObject? as? String) ?? ""
                SubcatMaster.description = (jObject["description"] as AnyObject? as? String) ?? ""
                
                
                SubcatMaster.facility = (jObject["facility"] as AnyObject? as? String) ?? ""
                SubcatMaster.land = (jObject["land"] as AnyObject? as? String) ?? ""
                SubcatMaster.mobile = (jObject["mobile"] as AnyObject? as? String) ?? ""
                SubcatMaster.mobilenumber = (jObject["mobilenumber"] as AnyObject? as? String) ?? ""
                
                SubcatMaster.name = (jObject["name"] as AnyObject? as? String) ?? ""
                SubcatMaster.offer = (jObject["offer"] as AnyObject? as? String) ?? ""
                
                SubcatMaster.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                SubcatMaster.pin = (jObject["pin"] as AnyObject? as? String) ?? ""
                SubcatMaster.randomid = (jObject["randomid"] as AnyObject? as? String) ?? ""
                SubcatMaster.result = (jObject["result"] as AnyObject? as? String) ?? ""
                
                SubcatMaster.state = (jObject["state"] as AnyObject? as? String) ?? ""
                SubcatMaster.street = (jObject["street"] as AnyObject? as? String) ?? ""
                SubcatMaster.ulat = (jObject["ulat"] as AnyObject? as? String) ?? ""
                SubcatMaster.ulong = (jObject["ulong"] as AnyObject? as? String) ?? ""
                
                
                SubcatMaster.dealtitle = (jObject["dealtitle"] as AnyObject? as? String) ?? ""
                SubcatMaster.dealdesc = (jObject["dealdesc"] as AnyObject? as? String) ?? ""
                SubcatMaster.dealactualprice = (jObject["dealactualprice"] as AnyObject? as? String) ?? ""
                SubcatMaster.dealdiscountprice = (jObject["dealdiscountprice"] as AnyObject? as? NSNumber) ?? 0
           //     SubcatMaster.dealofferprice = (jObject["dealofferprice"] as AnyObject? as? NSNumber) ?? 0
                SubcatMaster.dealvalfrom = (jObject["dealvalfrom"] as AnyObject? as? String) ?? ""
                SubcatMaster.dealvalto = (jObject["dealvalto"] as AnyObject? as? String) ?? ""
                SubcatMaster.percentage = (jObject["percentage"] as AnyObject? as? String) ?? ""
                SubcatMaster.term1 = (jObject["term1"] as AnyObject? as? String) ?? ""
                SubcatMaster.term2 = (jObject["term2"] as AnyObject? as? String) ?? ""
                SubcatMaster.term3 = (jObject["term3"] as AnyObject? as? String) ?? ""
                SubcatMaster.dealphoto = (jObject["dealphoto"] as AnyObject? as? String) ?? ""
                
                SubcatMaster.cat_id = (jObject["cat_id"] as AnyObject? as? String) ?? ""
                SubcatMaster.subcat_id = (jObject["subcat_id"] as AnyObject? as? String) ?? ""
                SubcatMaster.distance = (jObject["distance"] as AnyObject? as? String) ?? ""
                SubcatMaster.reach = (jObject["reach"] as AnyObject? as? String) ?? ""
                SubcatMaster.like = (jObject["like"] as AnyObject? as? String) ?? ""
                SubcatMaster.deal = (jObject["deal"] as AnyObject? as? NSNumber) ?? 0
                SubcatMaster.user_email = (jObject["user_email"] as AnyObject? as? String) ?? ""
                SubcatMaster.user_website = (jObject["user_website"] as AnyObject? as? String) ?? ""
                SubcatMaster.randomid = (jObject["randomid"] as AnyObject? as? String) ?? ""
                
                
            }
            
            
            self.DataOfThePage()
            mainTableView.reloadData()
           
        }
        else{
        
           print("NOT DATA FOUND")
        
        }
        
    }
    
    
    func DataOfThePage(){
        
         let imgurl:String = SubcatMaster.photo
        
         bannerImage.kf.setImage(with: Foundation.URL(string: imgurl)!,placeholder: nil)
        
        businessLabel.text = SubcatMaster.name
        placeLabel.text = SubcatMaster.street + ", " + SubcatMaster.city
        diatanceLabel.text = SubcatMaster.distance
        reachesLabel.text = SubcatMaster.reach
        likesLabel.text = SubcatMaster.like
        descTextView.text = SubcatMaster.description
         descTextView.font = UIFont(name: "Poppins-Regular", size: 14)
        webTextView.text = SubcatMaster.user_website
        phoneLabel.text = SubcatMaster.mobilenumber
        addressLabel.text = SubcatMaster.street + ", " + SubcatMaster.city + ", " + SubcatMaster.country + ", " + SubcatMaster.country + "-" + SubcatMaster.pin
        
        
        
    }
    
    
    func calculateHeight(inString:String) -> CGFloat {
        let messageString = inString
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.row == 0 {
            
            let firstRowHeight = 230
            
            return CGFloat(firstRowHeight)
        }
        else if indexPath.row == 1 {
            
            let secondRowHeight = 124
            
            return CGFloat(secondRowHeight)
        }
        else if indexPath.row == 2 {
            
            let thirdRowHeight = 113
            
            return CGFloat(thirdRowHeight)
        }
        else if indexPath.row == 3 {
          
            
            let fixedWidth = descTextView.frame.size.width
            descTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = descTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = descTextView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            descTextView.frame = newFrame
            
            print("FRAMEHEIGHT = \(descTextView.frame.height)")
            let caluheight = self.calculateHeight(inString: descTextView.text)
            print("calucuHEIght = \(caluheight)")
            
            return (descTextView.frame.height + 90)
            
        }
        else if indexPath.row == 4 {
            
            return 195
            // return tableView.frame.size.height - 230 - 124 - 113 - CGFloat(heightRow)
        }else{
            return tableView.frame.size.height
        }
    }
    
    
    @IBAction func dealButton(_ sender: Any) {
        print("DEALS Here")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

   

}
