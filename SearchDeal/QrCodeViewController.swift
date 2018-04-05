//
//  QrCodeViewController.swift
//  SearchDeal
//
//  Created by quiqinfotech on 10/4/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import AVFoundation

class QrCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

   // @IBOutlet weak var lblQRCodeResult: UILabel!
   // @IBOutlet weak var lblQRCodeLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dealAble: UILabel!
    @IBOutlet weak var Dframe: UIImageView!
    
    var page:Int = 0
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCode:UIView?
    
//    var latitude = ""
//    var longitude = ""
 
    var locations:locationMode = locationMode()
   // var QRValue = "http://searchdeal.co.in"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
        
        print("LATO = \(locations.latitude)")
        print("LONGGO = \(locations.longitude)")
        
        backButton.setTitle("", for: UIControlState())
        
       

    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
         self.dismiss(animated: true, completion: nil)
        
      
    }
    
    // this func below helps to capture vedio data of type QRcode
    func configureVideoCapture() {
        let objCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var error:NSError?
        let objCaptureDeviceInput: AnyObject!
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
            
        } catch let error1 as NSError {
            error = error1
            objCaptureDeviceInput = nil
        }
        if (error != nil) {
            let alertView:UIAlertView = UIAlertView(title: "Device Error", message:"Device not Supported for this Application", delegate: nil, cancelButtonTitle: "Ok Done")
            alertView.show()
            return
        }
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    
    // this func below give a layer of images before the camera view and also tells to start capturing vedio
    func addVideoPreviewLayer() {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
      //  self.view.bringSubviewToFront(lblQRCodeResult)
       // self.view.bringSubviewToFront(lblQRCodeLabel)
        self.view.bringSubview(toFront: image)
        self.view.bringSubview(toFront: dealAble)
        self.view.bringSubview(toFront: Dframe)
        

    }
    
    func initializeQRView() {
        vwQRCode = UIView()
       // vwQRCode?.layer.borderColor = red
        //vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubview(toFront: vwQRCode!)
        //self.view.bringSubviewToFront(backButton)
    }
    
    func deinitializeQRView() {
        vwQRCode = UIView()
        // vwQRCode?.layer.borderColor = nil
        //vwQRCode?.layer.borderWidth = 5
        self.view.willRemoveSubview(vwQRCode!)
        //self.view.bringSubview(toFront: vwQRCode!)
        //self.view.bringSubviewToFront(backButton)
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRect.zero
         //   lblQRCodeResult.text = "NO QRCode text detacted"
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObject(for: objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
               // lblQRCodeResult.text = objMetadataMachineReadableCodeObject.stringValue
                let QRValue = objMetadataMachineReadableCodeObject.stringValue
                NSLog("QRVALUE = %@",QRValue ?? " ")
                if(QRValue != nil)
                {
                  
                 objCaptureSession?.stopRunning()
                    
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
//                    present(vc, animated: true, completion: nil)
                    
                    
                  
                    
                    let storyboard = UIStoryboard(name: "Main2", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ToQRdetailPageViewController") as! ToQRdetailPageViewController
                    vc.qrcode = QRValue!
                    vc.locations = locations
                    self.present(vc, animated:true, completion: nil)
                   // vc.page = 2
                    //let navController = UINavigationController(rootViewController: vc)
                    //self.present(vc, animated:true, completion: nil)

                   
                    
                   
                    

                    //self.presentViewController(vc, animated: true, completion: nil)
                }
            }
        }
    }
}

//extension UIApplication {
//    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = viewController as? UINavigationController {
//            return topViewController(viewController: nav.visibleViewController)
//        }
//        if let tab = viewController as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(viewController: selected)
//            }
//        }
//        if let presented = viewController?.presentedViewController {
//            return topViewController(viewController: presented)
//        }
//        return viewController
//    }
//}

