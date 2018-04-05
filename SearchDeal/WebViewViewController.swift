//
//  WebViewViewController.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 17/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WebViewViewController: UIViewController,UIWebViewDelegate,NVActivityIndicatorViewable {
    
    
    @IBOutlet var buttonBack: UIButton!
    
    @IBOutlet var webview: UIWebView!

    
    var LoadURL:String = ""
    var backTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         webview.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
        buttonBack.setTitle(backTitle, for: UIControlState())
        buttonBack.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        
        let url : URL! = URL(string: LoadURL)
        webview.loadRequest(URLRequest(url: url))


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func webViewDidStartLoad(_ webView: UIWebView){
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballClipRotate, color: AppColor.AppRed, padding: 10)
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        
        self.stopAnimating()
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
         self.stopAnimating()
      
    }

    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }

 
    
}
