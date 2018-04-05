//
//  ViewEffects.swift
//  Carbon Kit Swift
//
//  Created by Quiqinfotech Capitan on 21/03/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

import Foundation
import UIKit

open class ViewEffects {


/*  Plane Shadow  for View  */



func applyPlainShadow(_ view: UIView) {
    
    let layer = view.layer
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 10)
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 5
    
}

    
    
    
    
    
    func applyCornerRadius(_ view: UIView,CornerRadi:CGFloat,shadowRadi:CGFloat,shadowColor:CGColor) {
        
        let layer = view.layer
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = shadowRadi
        layer.cornerRadius = CornerRadi
    }

    
    
    

/*  Curved Shadow  for View  */


func applyCurvedShadow(_ view: UIView) {
    let size = view.bounds.size
    let width = size.width
    let height = size.height
    let depth = CGFloat(11.0)
    let lessDepth = 0.8 * depth
    let curvyness = CGFloat(5)
    let radius = CGFloat(1)
    
    let path = UIBezierPath()
    
    // top left
    path.move(to: CGPoint(x: radius, y: height))
    
    // top right
    path.addLine(to: CGPoint(x: width - 2*radius, y: height))
    
    // bottom right + a little extra
    path.addLine(to: CGPoint(x: width - 2*radius, y: height + depth))
    
    // path to bottom left via curve
    path.addCurve(to: CGPoint(x: radius, y: height + depth),
        controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
        controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
    
    let layer = view.layer
    layer.shadowPath = path.cgPath
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.3
    layer.shadowRadius = radius
    layer.shadowOffset = CGSize(width: 0, height: -3)
}


/*  Hover Shadow  for View  */

func applyHoverShadow(_ view: UIView) {
    let size = view.bounds.size
    let width = size.width
    let height = size.height
    
    let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
    let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
    
    let layer = view.layer
    layer.shadowPath = path.cgPath
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowRadius = 5
    layer.shadowOffset = CGSize(width: 0, height: 0)
}

}
