
//
//  LocalDB.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 15/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import Foundation
open class LocalDB {

    /* LOCAL DATABASE INITIALIZATION  */
    
    
    class func DBInit(){
    
        let defaults = UserDefaults.standard

        if defaults.object(forKey: "email") == nil || defaults.string(forKey: "email") == ""{
            
            defaults.set("", forKey: "email")
            
        }
        

    }
    
    /* CLEAR LOCAL DATABASE */
    
    class func DBClearData(){
    
    
        let defaults = UserDefaults.standard
        
        defaults.set("", forKey: "email")
    
    }
   
     let defaults = UserDefaults.standard
    open func setEmail( _ email:String){
        
        defaults.set(email, forKey: "email")
    }

    
    open func getEmail()->String{
        
        return defaults.string(forKey: "email")!
    }




}
