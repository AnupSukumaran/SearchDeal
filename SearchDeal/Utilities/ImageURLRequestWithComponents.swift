
//
//  ImageURLRequestWithComponents.swift
//  SearchDeal
//
//  Created by Ajithkumar M on 16/07/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import Foundation
import Alamofire

open class ImageURLRequestWithComponents{


    
//    // this function creates the required URLRequestConvertible and NSData we need to use Alamofire.upload
//    func urlRequestWithComponents(urlString:String, parameters:Dictionary<String, String>, imageData:NSData,filePathkey:String,fileName:String) -> (URLRequestConvertible, NSData) {
//        
//        
//      //  var url: NSURL = NSURL(string: urlString)!
//        // create url request to send
//        var mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL )
//        mutableURLRequest.httpMethod = Alamofire.HTTPMethod.post.rawValue
//        let boundaryConstant = "myRandomBoundary12345";
//        let contentType = "multipart/form-data;boundary="+boundaryConstant
//        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
//        
//        
//        
//        // create upload data to send
//        let uploadData = NSMutableData()
//        
//        // add image
//       // Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n
//        uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
//        uploadData.append(" Content-Disposition: form-data; name=\"\(filePathkey)\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
//        uploadData.append("Content-Type: image/jpg\r\n\r\n".data(using: String.Encoding.utf8)!)
//        uploadData.append(imageData as Data)
//        
//        // add parameters
//        for (key, value) in parameters {
//            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
//            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
//        }
//        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
//        
//        
//        
//        // return URLRequestConvertible and NSData
//        return (Alamofire.ParameterEncoding.url.encode(mutableURLRequest, parameters: nil).0, uploadData)
        
 //   }
}

//// create url request to send
//let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
//mutableURLRequest.HTTPMethod = Alamofire.Method.PUT.rawValue
//let boundaryConstant = "FileUploader-boundary-\(arc4random())-\(arc4random())";
//let contentType = "multipart/form-data;boundary="+boundaryConstant
//mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
//
//// create upload data to send
//let uploadData = NSMutableData()
//
//for var i = 0; i < imageData.count; ++i {
//    // add image
//    uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//    uploadData.appendData("Content-Disposition: form-data; name=\"\(inputName)\(i+1)\"; filename=\"image\(i+1).jpg\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//    uploadData.appendData("Content-Type: image/jpeg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//    uploadData.appendData(imageData[i])
//}
//
//// add parameters
//for (key, value) in parameter {
//    uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//    uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
//    print("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)")
//}
//uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
//
//print("Content-Disposition: form-data; name=\"\(inputName)\"; filename=\"image.jpg\"\r\n")
//
//// return URLRequestConvertible and NSData
//return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
