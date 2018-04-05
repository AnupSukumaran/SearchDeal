//
//  ButtonExtender.swift
//  SearchDeal
//
//  Created by quiqinfotech on 27/09/17.
//  Copyright © 2017 Quiqinfotech Softwares. All rights reserved.
//

//
//  ButtonExtender.swift
//  IBButtonExtender
//
//  Created by Ashish on 08/08/15.
//  Copyright (c) 2015 Ashish. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class ButtonExtender: UIButton {
    //MARK: PROPERTIES
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornurRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornurRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0.0 {
        
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
          
            
        }
    }
    
    
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        
        didSet {
            layer.shadowRadius = shadowRadius
           
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero{
        
        didSet {
            layer.shadowOffset = shadowOffset
            
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
             layer.shadowColor = shadowColor.cgColor
            
        }
    }
    
    @IBInspectable var maskToBounds: Bool = false {
        
        didSet {
            layer.masksToBounds = maskToBounds
            
        }
    }
    
    //MARK: Initializers
    override init(frame : CGRect) {
        super.init(frame : frame)
        setup()
        configure()
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        configure()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
    }
    
    func setup() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 1.0
    }
    
    func configure() {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornurRadius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

