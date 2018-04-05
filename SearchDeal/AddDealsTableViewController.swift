//
//  AddDealsTableViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 03/11/17.
//

import UIKit
import SkyFloatingLabelTextField





class AddDealsTableViewController: UITableViewController, UITextViewDelegate {

    
    //@IBOutlet weak var DealTitle: UITextView!
    
    
    //@IBOutlet weak var DealDescription: UITextView!
    
    @IBOutlet weak var dealTitle: UITextView!
    
    @IBOutlet weak var dealDescription: UITextView!
    
    
    @IBOutlet weak var underlineView: UIView!
    
    var textViews: [UITextView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViews = [dealTitle, dealDescription]
        
       

        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        for textViewData in textViews {
            textViewData.delegate = self
            //textViewData.placeholderTextColor = UIColor.lightGray
            
        }
        
       // dealTitle.placeholder = "DealTile"
       // dealDescription.placeholder = "Deal description"
       
        
        
        
        
    }
    
//    override func viewDidLayoutSubviews() {
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.red.cgColor
//
//        for textViewData in textViews {
//            print("TEXTCALLED")
//             border.frame = CGRect(x: 0, y: textViewData.frame.size.height - width, width:  textViewData.frame.size.width, height: textViewData.frame.size.height)
//
//            border.borderWidth = width
//            textViewData.layer.addSublayer(border)
//
//            textViewData.layer.masksToBounds = true
//        }
//
//    }
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
            let currentOffset = tableView.contentOffset
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            tableView.setContentOffset(currentOffset, animated: false)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        UIView.animate(withDuration: 0.4, animations: )
//        underlineView.backgroundColor = UIColor.red
        
        if textView == self.dealTitle{
            UIView.animate(withDuration: 0.8) {
                self.underlineView.backgroundColor = UIColor.red
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
         if textView == self.dealTitle{
            UIView.animate(withDuration: 0.8) {
                self.underlineView.backgroundColor = UIColor.black
            }
        }
    }

    func updateTableViewContentOffsetForTextView() {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
    
  
//    func calculateHeight(inString:String) -> CGFloat {
//        let messageString = inString
//        let attributes : [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 17.0)]
//
//        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
//
//        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
//
//        let requredSize:CGRect = rect
//        return requredSize.height
//    }
    
   
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
//
//        if indexPath.row == 0{
//
//            if textView.text.isEmpty {
//                let firstRowHeight = 157
//
//                return CGFloat(firstRowHeight)
//
//            }else{
//                let BrandNewSize = calculateHeight(inString: textView.text!)
//                print("BrandNewSize = \(BrandNewSize)")
//                return BrandNewSize + 20
//
//            }
//
//
//        }else if indexPath.row == 1 {
//
//            let secondRowHeight = 157
//
//            return CGFloat(secondRowHeight)
//
//        }else if indexPath.row == 2 {
//
//            let thirdRowHeight = 157
//
//            return CGFloat(thirdRowHeight)
//
//        }else if indexPath.row == 3{
//
//            let fourthRowHeight = 157
//
//            return CGFloat(fourthRowHeight)
//
//        }else if indexPath.row == 4{
//
//            let fourthRowHeight = 157
//
//            return CGFloat(fourthRowHeight)
//
//        }else if indexPath.row == 5{
//
//            let fourthRowHeight = 157
//
//            return CGFloat(fourthRowHeight)
//
//        }else{
//
//            return tableView.frame.size.height
//        }
//
//    }

    // MARK: - Table view data source

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

//extension AddDealsTableViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        let currentOffset = tableView.contentOffset
//        UIView.setAnimationsEnabled(false)
//        tableView.beginUpdates()
//        tableView.endUpdates()
//        UIView.setAnimationsEnabled(true)
//        tableView.setContentOffset(currentOffset, animated: false)
//    }
//
//    func updateTableViewContentOffsetForTextView() {
//        let currentOffset = tableView.contentOffset
//        UIView.setAnimationsEnabled(false)
//        tableView.beginUpdates()
//        tableView.endUpdates()
//        UIView.setAnimationsEnabled(true)
//        tableView.setContentOffset(currentOffset, animated: false)
//    }
//}

