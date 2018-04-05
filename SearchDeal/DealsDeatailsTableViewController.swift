//
//  DealsDeatailsTableViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 25/10/17.
//

import UIKit
import Kingfisher

class DealsDeatailsTableViewController: UITableViewController {

    var SingelBUZZDeals:DealModal = DealModal()
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet var dealTable: UITableView!
    
    @IBOutlet weak var uiviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var BusinessTitleLabel: UILabel!
    
    @IBOutlet weak var promoCodelabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
   
    @IBOutlet weak var streetCityLabel: UILabel!
    
    @IBOutlet weak var statePinLabel: UILabel!
    
    @IBOutlet weak var dealValTo: UILabel!
    
    @IBOutlet weak var term1Label: UILabel!
    
    @IBOutlet weak var term2Label: UILabel!
    
    
    @IBOutlet weak var term3Label: UILabel!
    
    @IBOutlet weak var DealViewLabel: UILabel!
    
    
    @IBOutlet weak var imageData: UIImageView!
    
    var labelHeight:CGFloat = 0
    
    @IBOutlet weak var backAction: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
        print("Descp = \(SingelBUZZDeals.description)" )
        
        
      //  dealTable.rowHeight = UITableViewAutomaticDimension
    //    dealTable.estimatedRowHeight = 169
        
        descLabel.text = SingelBUZZDeals.description
        descLabel.font = UIFont(name: "Poppins-Regular", size: 14)
        
        
        BusinessTitleLabel.text = SingelBUZZDeals.dealtitle
        promoCodelabel.text = SingelBUZZDeals.promocode
        nameLabel.text = SingelBUZZDeals.name
        streetCityLabel.text = SingelBUZZDeals.street + ", " +  SingelBUZZDeals.city
        statePinLabel.text = SingelBUZZDeals.state + " - " + SingelBUZZDeals.pincode
        dealValTo.text = "\u{2022} " + "Valid till " + SingelBUZZDeals.dealvalto
        term1Label.text = "\u{2022} " + SingelBUZZDeals.term1
        term2Label.text = "\u{2022} " + SingelBUZZDeals.term2
        term3Label.text = "\u{2022} " + SingelBUZZDeals.term3
        DealViewLabel.text = SingelBUZZDeals.dealview
        
         let imgUrl = URL(string: SingelBUZZDeals.dealphoto)
         imageData.kf.indicatorType = .activity
        imageData.kf.setImage(with: imgUrl!, placeholder: nil, options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
       
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
       
        dealTable.reloadData()
    }
    

    //MARK: Func To Calulate the Height of content of textField
    
    func calculateHeight(inString:String) -> CGFloat {
        let messageString = inString
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 17.0)]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        
        if indexPath.row == 0{
            print("Works123 = \(labelHeight)")
            
            let BrandNewSize = calculateHeight(inString: descLabel.text!)
            print("BrandNewSize = \(BrandNewSize)")
            return BrandNewSize + 20
            
        }else if indexPath.row == 1 {
            
            let secondRowHeight = 134
            
            return CGFloat(secondRowHeight)
            
        }else if indexPath.row == 2 {
            
            let thirdRowHeight = 112
            
            return CGFloat(thirdRowHeight)
            
        }else if indexPath.row == 3{
            
            let fourthRowHeight = 180
            
            return CGFloat(fourthRowHeight)
            
        }else{
            
            return tableView.frame.size.height
        }
        
    }
    
    
  
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 179
//    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//
//        if indexPath.row == 0 {
//
//
//            let firstRowHeight = self.calculateHeight(inString: descLabel.text!)
//
//            return CGFloat(firstRowHeight + 8)
//        }
//        else if indexPath.row == 1 {
//
//            let secondRowHeight = 134
//
//            return CGFloat(secondRowHeight)
//        }
//        else if indexPath.row == 2 {
//
//            let thirdRowHeight = 144
//
//            return CGFloat(thirdRowHeight)
//        }else if indexPath.row == 3{
//
//            let fourthRowHeight = 169
//
//            return CGFloat(fourthRowHeight)
//        }else{
//            return tableView.frame.size.height
//        }
////        else if indexPath.row == 3 {
////
////            let fixedWidth = desc.frame.size.width
////            desc.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
////            let newSize = desc.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
////            var newFrame = desc.frame
////            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
////            desc.frame = newFrame
////
////            print("FRAMEHEIGHT = \(desc.frame.height)")
////            let caluheight = self.calculateHeight(inString: desc.text)
////            print("calucuHEIght = \(caluheight)")
////
////            return (desc.frame.height + 90)
////
////
////        }
////        else if indexPath.row == 4 {
////
////            return 195
////
////        }else{
////            return tableView.frame.size.height
////        }
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
