//
//  DetailViewTableViewController.swift
//  SearchDeal
//
//  Created by Sukumar Anup Sukumaran on 17/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewTableViewController: UITableViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var title1: UILabel!
    
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var distanceTitle: UILabel!
    
    
    @IBOutlet weak var reachesTitle: UILabel!
    
    
    @IBOutlet weak var likeTitle: UILabel!
    
    
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var webSite: UILabel!
    
    @IBOutlet weak var phoneNum: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
   
    
    
    @IBOutlet weak var descCell: UITableViewCell!
    
    @IBOutlet weak var favButton: UIButton!
    
    var SubcatMasterList2:SubCatagoryMasterList = SubCatagoryMasterList()
    
  //  var favValue:Bool = false
    @IBOutlet weak var textViewHeightConstrains: NSLayoutConstraint!
    
    var params = [String:String]()
    
    var URLs:String = ""
    
     var Imeino = UserDefaults.standard.object(forKey: "userUniqueId") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        let imageURL:String = SubcatMasterList2.photo
        print("IMAGEURL = \(imageURL)")
        bannerImage.kf.setImage(with: URL(string: imageURL))
        


        title1.text = SubcatMasterList2.name
        title2.text = SubcatMasterList2.street + ", " + SubcatMasterList2.city
        distanceTitle.text = SubcatMasterList2.distance
        reachesTitle.text = SubcatMasterList2.reach
        likeTitle.text = SubcatMasterList2.like
        
        desc.text = SubcatMasterList2.description
        desc.font = UIFont(name: "Poppins-Regular", size: 14)
        addressLabel.text = SubcatMasterList2.street + ", " + SubcatMasterList2.city + ", " + SubcatMasterList2.country + ", " + SubcatMasterList2.pin
        
         let subStree = SubcatMasterList2.user_website.isEmpty ? "-":SubcatMasterList2.user_website
        
        webSite.text = subStree
        phoneNum.text = SubcatMasterList2.mobilenumber
        
        
        
//        if (UserDefaults.standard.object(forKey:"favValue") as? Bool) == true{
//            favButton.setImage(UIImage(named:"yellowHeart"), for: .normal)
//        }else{
//            favButton.setImage(UIImage(named:"whiteHeart"), for: .normal)
//        }
        
//        var frame:CGRect = desc.frame
//        frame.size.height = desc.contentSize.height
//        desc.frame = frame
//        textContentHeight.constant = desc.contentSize.height
        

    }
    
    @IBAction func favButton(_ sender: Any) {
        
       // favValue = true
        
       favButton.setImage(UIImage(named: "yellowHeart"), for: UIControlState.normal)
     
        
        print("pid = \(SubcatMasterList2.randomid), imeino = \(Imeino), catid = \(SubcatMasterList2.cat_id), subid = \(SubcatMasterList2.subcat_id)")
        
        self.params = [
            "pid":SubcatMasterList2.randomid,
            "imeino":Imeino,
            "catid":SubcatMasterList2.cat_id,
            "subid":SubcatMasterList2.subcat_id
            
        ]
        
         self.URLs = urlClass().url1 + "user_like.php?"
        
        
        
        Alamofire.request( self.URLs, method: .get,  parameters:self.params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)

                case .failure(let error):
                    print("ERRRORR = \(error)")
                    // return userCatagory
                }
        }

        
    }
    
     func jsonResultParse( _ json:AnyObject){
        
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dealHere(_ sender: Any) {
        let alert = UIAlertController(title: OSConstants.APPLICATION_NAME(), message: "Not available", preferredStyle: UIAlertControllerStyle.alert)
        
        
        self.present(alert, animated: true, completion: nil)
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            
            alert.dismiss(animated: true, completion: nil)
        })

    }
    
    
    //MARK: Func To Calulate the Height of content of textField
    
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
           
            let fixedWidth = desc.frame.size.width
            
            print("FIXED Width = \(fixedWidth)")
            desc.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = desc.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = desc.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            desc.frame = newFrame

            print("FRAMEHEIGHT = \(desc.frame.height)")
            let caluheight = self.calculateHeight(inString: desc.text)
            print("calucuHEIght = \(caluheight)")
            
            return (desc.frame.height + 90)
           

        }
        else if indexPath.row == 4 {
            
            return 195
           // return tableView.frame.size.height - 230 - 124 - 113 - CGFloat(heightRow)
        }else{
            return tableView.frame.size.height
        }
    }
    
//    func adjustUITextViewHeight(arg : UITextView)
//    {
//        arg.translatesAutoresizingMaskIntoConstraints = true
//        arg.sizeToFit()
//        arg.isScrollEnabled = false
//    }

//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
