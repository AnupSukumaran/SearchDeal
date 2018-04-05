//
//  NearBySearchCatagoryDetailViewController.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 06/08/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import UIKit
import GoogleMaps

class NearBySearchCatagoryDetailViewController: UIViewController,GMSMapViewDelegate ,CLLocationManagerDelegate {
    
    @IBOutlet var buttonBack: UIButton!
    
    @IBOutlet var googleMAp: GMSMapView!
    
    @IBOutlet var title1: UILabel!

    @IBOutlet var title2: UILabel!
    
    @IBOutlet var buttonDirection: UIButton!
    
    @IBOutlet var buttonMapView: UIButton!
    
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var zoom:Float = 15
    
    var name:String = ""
    var lat:String=""
    var lng:String=""
   
    var vicinity:String=""
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            googleMAp.isMyLocationEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBack.setTitle(name, for: UIControlState())
        buttonBack.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)!
        title1.text = name
        title2.text = vicinity
        
        self.googleMAp.delegate = self
        self.googleMAp.isMyLocationEnabled=true
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 100.0)
        
        latitude = CLLocationDegrees(lat)
        longitude = CLLocationDegrees(lng)
        let  position = CLLocationCoordinate2DMake(latitude!,longitude!)
        self.googleMAp.animate(toLocation: position)
        self.googleMAp.camera = GMSCameraPosition(target: position, zoom: 15, bearing: 30, viewingAngle: 0)
        self.googleMAp.animate(toZoom: 15)
        self.googleMAp.animate(toViewingAngle: 0)
        var marker = GMSMarker()
        marker = GMSMarker(position: position)
        marker.map = self.googleMAp


        
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let InfoWindow: CustomMarkerView = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)![0] as! CustomMarkerView
        InfoWindow.title1.text = name
        InfoWindow.title2.text = vicinity
        InfoWindow.heightLabel2.constant=40
        InfoWindow.title3.text=""
        buttonDirection.isHidden = false
        buttonMapView.isHidden = false
        
        return InfoWindow
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionZoomOut(_ sender: AnyObject) {
        
        //+
        zoom = zoom+2
        
        if zoom >= 35{
            
        }
        else{
            latitude = CLLocationDegrees(lat)
            longitude = CLLocationDegrees(lng)
            let  position = CLLocationCoordinate2DMake(latitude!,longitude!)
            self.googleMAp.animate(toLocation: position)
            self.googleMAp.camera = GMSCameraPosition(target: position, zoom: zoom, bearing: 30, viewingAngle: 0)
        }
        

        
    }
    
    
    @IBAction func actionZoomIn(_ sender: AnyObject) {
        
        //-
        zoom = zoom-2
        
        if zoom <= 0{
            
        }
        else{
            latitude = CLLocationDegrees(lat)
            longitude = CLLocationDegrees(lng)
            let  position = CLLocationCoordinate2DMake(latitude!,longitude!)
            self.googleMAp.animate(toLocation: position)
            self.googleMAp.camera = GMSCameraPosition(target: position, zoom: zoom, bearing: 30, viewingAngle: 0)
        }

    }
    
    
    @IBAction func actionDirection(_ sender: AnyObject) {
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=transit")!)
            
        } else {
            NSLog("Can't use comgooglemaps://");
            
            let s="http://maps.google.com/maps?saddr=&daddr=\(lat),\(lng)&directionsmode=transit"
            print(s)
            let url =  URL(string:s)!
            
            UIApplication.shared.openURL(url)
            
        }

        
        
    }
    
    @IBAction func GetDirection(_ sender: AnyObject) {
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=transit")!)
            
        } else {
            NSLog("Can't use comgooglemaps://");
            
            let s="http://maps.google.com/maps?saddr=&daddr=\(lat),\(lng)&directionsmode=transit"
            print(s)
            let url =  URL(string:s)!
            
            UIApplication.shared.openURL(url)
            
        }
    }
    
    @IBAction func actionShowMap(_ sender: AnyObject) {
    
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://?q=\(lat),\(lng)&zoom=15&views=traffic")!)
            
        } else {
            
            NSLog("Can't use comgooglemaps://");
            let s="http://maps.google.com/maps?q=\(lat),\(lng)&zoom=15&views=traffic"
            print(s)
            let url =  URL(string:s)!
            
            UIApplication.shared.openURL(url)
            
            
        }

    
    }
    
    
    
    
}
