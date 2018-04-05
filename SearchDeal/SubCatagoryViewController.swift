//
//  SubCatagoryViewController.swift
//  SearchDeal
//
//  Created by Quiqinfotech on 10/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import DropDown
import Kingfisher

class SubCatagoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

   // @IBOutlet weak var webView: UIWebView!
    
    
    var subcatagory = [SubCatagory]()
    
    @IBOutlet weak var categoryIcon: UIImageView!
   
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var imageFromHome: UIImageView!
    
    @IBOutlet weak var reachesLabel: UILabel!
    
    
    @IBOutlet weak var subCatagoryTable: UITableView!
    
    
    @IBOutlet weak var labelNoResultsFound: UILabel!
    
    var viewEffects = ViewEffects()
    
    var cat_id = ""
    var cat_title = ""
    var photoData = ""
    var latitude = ""
    var longitude = ""
    var iconNum = 0
    var reachesCount = ""
    var iconName = ""
    var newPlace = ""
    
   // @IBOutlet weak var menuButton: UIButton!
   
   // let rightMenuDropDown = DropDown()
    
//    lazy var dropDown: [DropDown] = {
//        return [self.rightMenuDropDown]
//    }()
    
    var imageIcons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10","11","12", "13","14","15","16","17","18","19","20","21","22", "23", "24"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        subCatagoryTable.delegate=self
        subCatagoryTable.dataSource=self
        
//        self.setupLeftMenuBarDropDown()
//        rightMenuDropDown.dismissMode = .onTap
//        rightMenuDropDown.direction = .bottom
//        rightMenuDropDown.bottomOffset = CGPoint(x: 12, y: (rightMenuDropDown.anchorView?.plainView.bounds.height)! + 7)

        
        let url = URL(string: photoData)
        
        imageFromHome.kf.setImage(with: url)
        
//        rightMenuDropDown.backgroundColor = UIColor.white
//        rightMenuDropDown.selectionBackgroundColor = UIColor.white
//        rightMenuDropDown.cellHeight = 50
//        rightMenuDropDown.width = 180
//        //rightMenuDropDown.textFont = UIFont.systemFont(ofSize: 18)
//        rightMenuDropDown.textFont = UIFont(name: "Poppins-Regular", size: 16)!
        
       // viewSvgImage()
        
        print("CATID@@# = \(cat_id)")

        self.categoryIcon.image = UIImage(named: imageIcons[iconNum])
        self.reachesLabel.text = reachesCount
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
       
        backButton.setTitle(cat_title, for: UIControlState())
        backButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        Alamofire.request( urlClass().url1 + "subcategorydemocopy.php?", method: .post, parameters: ["catid": cat_id])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.jsonResultParse(response.result.value! as AnyObject)
                case .failure(let error):
                    print("ERROR = \(error)")
                    
                    self.subCatagoryTable.isHidden = true
                    self.labelNoResultsFound.isHidden = false
                    // return userCatagory
                }
                self.stopAnimating()
        }
        


        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //viewDidAppear(true)
        if let indexPath = subCatagoryTable.indexPathForSelectedRow {
            subCatagoryTable.deselectRow(at: indexPath, animated: animated)
        }
    }
    
//    func viewSvgImage(){
//        let path: String = Bundle.main.path(forResource: "search-icon-hotel", ofType: "svg")!
//        
//        let url: NSURL = NSURL.fileURL(withPath: path) as NSURL  //Creating a URL which points towards our path
//        
//        //Creating a page request which will load our URL (Which points to our path)
//        let request: NSURLRequest = NSURLRequest(url: url as URL)
//        webView.loadRequest(request as URLRequest)  //Telling our webView to load our above request
//    }
    
    
//    @IBAction func showMeMenu(_ sender: Any) {
//        rightMenuDropDown.show()
//    }
    
//    func setupLeftMenuBarDropDown(){
//        
//        rightMenuDropDown.anchorView = menuButton
//        
//        
//        
//        rightMenuDropDown.dataSource = ["Post Your Business",
//                                       "FAQ",
//                                       "Merchant Login",
//                                       "Invite Friends"]
//        
//        rightMenuDropDown.selectionAction = { (index: Int, item: String) in switch index{
//        case 0:  self.funcWebView("http://searchdeal.co.in/business-profile/business-public",backTitle: "Post Your Business")
//        case 1:  self.funcWebView("http://searchdeal.co.in/business-profile/business-public-faq",backTitle: "FAQ")
//        case 2:
////            let DB = LocalDB()
////            
////            if DB.getEmail() != "" {
////                self.funcAfterLogin()
////            }
////            else{
//                self.funcLogin()
//          //  }
//            
//        case 3:
//            let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "InviteFriendsViewController") as! InviteFriendsViewController
//            let navController = UINavigationController(rootViewController: vc)
//            self.present(navController, animated:true, completion: nil)
//            
//        default: print("Not valid")
//            }
//        }
//        
//        rightMenuDropDown.selectionBackgroundColor = UIColor.white
//        
//    }
    
    
    func jsonResultParse( _ json:AnyObject){
        
        subcatagory.removeAll()
        
        
        let JSONArray = json as! NSArray
        
        if JSONArray.count != 0 {
            
            for i:Int in 0 ..< JSONArray.count  {
                
                let jObject = JSONArray[i] as! NSDictionary
                
                let uCatagory:SubCatagory = SubCatagory()
                
                uCatagory.subid = (jObject["subid"] as AnyObject? as? String) ?? ""
                uCatagory.photo = (jObject["photo"] as AnyObject? as? String) ?? ""
                uCatagory.result = (jObject["reach"] as AnyObject? as? String) ?? ""
                uCatagory.subcategory = (jObject["subcategory"] as AnyObject? as? String) ?? ""
                uCatagory.deals = (jObject["deals"] as AnyObject? as? String) ?? ""
                
                
                subcatagory.append(uCatagory)
                
            }
            
            self.subCatagoryTable.isHidden = false
            self.labelNoResultsFound.isHidden = true
            self.subCatagoryTable.reloadData()
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func searchAction(_ sender: Any) {
        
        let new = UIStoryboard(name: "Main3", bundle: nil).instantiateViewController(withIdentifier: "SEARCH") as! SearchViewController
       // new.delegate =
        new.lat = latitude
        new.longi = longitude
        new.locationFromHome =  self.newPlace
        self.present(new, animated: true, completion: nil)
        
    }
   
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return subcatagory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubCatagoryTableViewCell
        
        cell.title1.text = subcatagory[indexPath.row].subcategory
        cell.title2.text = subcatagory[indexPath.row].result
      //  cell.tableIcon.image = UIImage(named: iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "SubCatagoryMasterListViewController") as! SubCatagoryMasterListViewController
        vc1.SUBCAT_ID = subcatagory[indexPath.row].subid
        vc1.cat_title = subcatagory[indexPath.row].subcategory
        vc1.latitude = self.latitude
        vc1.longitude = self.longitude
        vc1.Cat_ID = self.cat_id
        
        let navController = UINavigationController(rootViewController: vc1)
        self.present(navController, animated:true, completion: nil)
        
        
        
        
        
    }
    
    
//    func funcAfterLogin(){
//        
//        let viewController:UIViewController = UIStoryboard(name: "Main5", bundle: nil).instantiateViewController(withIdentifier: "AddDealViewController") as! AddDealViewController
//        let navController = UINavigationController(rootViewController: viewController)
//        self.present(navController, animated:true, completion: nil)
//       // self.presentViewController(viewController, animated: true, completion: nil)
//        
//    }
//    

    
    func funcLogin(){
        
        if (UserDefaults.standard.object(forKey: "Login") as? String) != nil{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MerchantMainViewController") as! MerchantMainViewController
            
            let navController = UINavigationController(rootViewController: vc)
            
            
            self.present(navController, animated:true, completion: nil)
        }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
            
            self.present(vc, animated:true, completion: nil)
            
        }
        
    }
    

    func funcWebView( _ url:String, backTitle:String){
        
        let storyboard = UIStoryboard(name: "Main4", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        vc.backTitle = backTitle
        vc.LoadURL = url
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
        //self.presentViewController(vc, animated: true, completion: nil)
        
    }

    

}
