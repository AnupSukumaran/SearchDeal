//
//  DealsCollectionViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 23/10/17.
//

import UIKit
import Kingfisher
import Alamofire
import NVActivityIndicatorView

private let reuseIdentifier = "DealsCollectionViewCell"


class DealsCollectionViewController: UICollectionViewController, NVActivityIndicatorViewable, UICollectionViewDelegateFlowLayout {
    
    var BUZZDeals = [DealModal]()
    
    var myLocation:locationMode = locationMode()
    
    fileprivate let itemsPerRow: CGFloat = 2
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    
    @IBOutlet var CollectionTable: UICollectionView!
   
    
    @IBOutlet weak var backAction: UIButton!
    
    @IBOutlet weak var NoResultsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
       NoResultsView.isHidden = true
//        backAction.setTitle("All Deals", for: UIControlState())
//        backAction.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "alldeals2copy.php", method: .post, parameters: ["long": myLocation.longitude, "lat": myLocation.latitude])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                   
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                    self.stopAnimating()
                case .failure(let error):
                    
                    print("ERROR1234 = ", error)
                    self.stopAnimating()
                    
                }
                
                
        }
    }
    
    func jsonResultParse( _ json:AnyObject){
        
        BUZZDeals.removeAll()
        
        let JSONArray = json as! NSArray
        
        if JSONArray.count != 0 {
            
            for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
                let uDeals:DealModal = DealModal()
                uDeals.id = (jObject["id"] as AnyObject? as? String) ?? ""
                uDeals.username = (jObject["username"] as AnyObject? as? String) ?? ""
                uDeals.dealtitle = (jObject["dealtitle"] as AnyObject? as? String) ?? ""
                
                uDeals.keywrd = (jObject["keywrd"] as AnyObject? as? String) ?? ""
                uDeals.discount = (jObject["discount"] as AnyObject? as? String) ?? ""
                uDeals.result = (jObject["result"] as AnyObject? as? String) ?? ""
                
                uDeals.dealdesc = (jObject["dealdesc"] as AnyObject? as? String) ?? ""
                uDeals.dealactualprice = (jObject["dealactualprice"] as AnyObject? as? String) ?? ""
                uDeals.dealvalfrom = (jObject["dealvalfrom"] as AnyObject? as? String) ?? ""
                
                
                uDeals.dealvalto = (jObject["dealvalto"] as AnyObject? as? String) ?? ""
                uDeals.percentage = (jObject["percentage"] as AnyObject? as? String) ?? ""
                uDeals.term1 = (jObject["term1"] as AnyObject? as? String) ?? ""
                
                uDeals.term2 = (jObject["term2"] as AnyObject? as? String) ?? ""
                uDeals.term3 = (jObject["term3"] as AnyObject? as? String) ?? ""
                uDeals.dealphoto = (jObject["dealphoto"] as AnyObject? as? String) ?? ""
                
                uDeals.created_at = (jObject["created_at"] as AnyObject? as? String) ?? ""
                uDeals.catid = (jObject["catid"] as AnyObject? as? String) ?? ""
                uDeals.subid = (jObject["subid"] as AnyObject? as? String) ?? ""
                
                uDeals.p_id = (jObject["p_id"] as AnyObject? as? String) ?? ""
                uDeals.distance = (jObject["distance"] as AnyObject? as? String) ?? ""
                uDeals.city = (jObject["city"] as AnyObject? as? String) ?? ""
                uDeals.street = (jObject["street"] as AnyObject? as? String) ?? ""
                uDeals.state = (jObject["state"] as AnyObject? as? String) ?? ""
                uDeals.pincode = (jObject["pincode"] as AnyObject? as? String) ?? ""
                uDeals.promocode = (jObject["promocode"] as AnyObject? as? String) ?? ""
                uDeals.category1 = (jObject["category1"] as AnyObject? as? String) ?? ""
                
                uDeals.category2 = (jObject["category2"] as AnyObject? as? String) ?? ""
                uDeals.name = (jObject["name"] as AnyObject? as? String) ?? ""
                uDeals.company = (jObject["company"] as AnyObject? as? String) ?? ""
                
                uDeals.mobile = (jObject["mobile"] as AnyObject? as? String) ?? ""
                uDeals.description = (jObject["description"] as AnyObject? as? String) ?? ""
                uDeals.user_email = (jObject["user_email"] as AnyObject? as? String) ?? ""
                uDeals.user_website = (jObject["user_website"] as AnyObject? as? String) ?? ""
                uDeals.door_no = (jObject["door_no"] as AnyObject? as? String) ?? ""
                
                uDeals.ulat = (jObject["ulat"] as AnyObject? as? String) ?? ""
                uDeals.ulong = (jObject["ulong"] as AnyObject? as? String) ?? ""
                uDeals.opens_at = (jObject["opens_at"] as AnyObject? as? String) ?? ""
                uDeals.closed_at = (jObject["closed_at"] as AnyObject? as? String) ?? ""
                uDeals.business_promocode = (jObject["business_promocode"] as AnyObject? as? String) ?? ""
                uDeals.qr_code = (jObject["qr_code"] as AnyObject? as? String) ?? ""
                uDeals.bcreated_at = (jObject["bcreated_at"] as AnyObject? as? String) ?? ""
                uDeals.user_plan = (jObject["user_plan"] as AnyObject? as? String) ?? ""
                uDeals.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                
                uDeals.uuid = (jObject["uuid"] as AnyObject? as? String) ?? ""
                uDeals.reach = (jObject["reach"] as AnyObject? as? String) ?? ""
                uDeals.like = (jObject["like"] as AnyObject? as? String) ?? ""
                
                uDeals.deal = (jObject["deal"] as AnyObject? as? NSNumber) ?? 0
                uDeals.dealview = (jObject["dealview"] as AnyObject? as? String) ?? ""
                
                BUZZDeals.append(uDeals)
            }
            self.NoResultsView.isHidden = true
            self.CollectionTable.reloadData()
    
            
        }else{
            self.NoResultsView.isHidden = false
            print("NO DATA")
        }
        
        
        
    }

    

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return BUZZDeals.count
    }

     //MARK: cellForRowAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DealsCollectionViewCell
    
        
        let imgUrl = URL(string: BUZZDeals[indexPath.row].dealphoto)
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: imgUrl!, placeholder: nil, options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        cell.hotelLabel.text = BUZZDeals[indexPath.row].name
        cell.dealtitle.text = BUZZDeals[indexPath.row].dealtitle
        cell.category1.text = BUZZDeals[indexPath.row].category1
        cell.dealvalto.text = BUZZDeals[indexPath.row].dealvalto
        cell.percentageLabel.text = BUZZDeals[indexPath.row].percentage
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("SectionInset.left = ", sectionInsets.left)
        print("itemsPerRow = ", itemsPerRow)
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        
        print("paddingSpace = ", paddingSpace)
        
        let availableWidth = view.frame.width - paddingSpace
        
        print("availableWidth = ", availableWidth)
        
        
        let widthPerItem = availableWidth / itemsPerRow
        
        print("widthPerItem = ", widthPerItem)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
  
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Working")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DealsDeatailsTableViewController") as! DealsDeatailsTableViewController
        
        vc.SingelBUZZDeals = BUZZDeals[indexPath.row]
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
        
    }
    //    func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//                let padding:CGFloat =  50
//                let collectionViewSize = collectionView.frame.size.width - padding
//
//        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
//    }
    
//    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//        let padding:CGFloat =  50
//        let collectionViewSize = collectionView.frame.size.width - padding
//
//        return CGSize(collectionViewSize/2, collectionViewSize/2)
//
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
