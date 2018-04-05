//
//  ButtonMod.swift
//  SearchDeal
//
//  Created by quiqinfotech on 27/09/17.
//  Copyright © 2017 Oranz Softwares. All rights reserved.
//

import Foundation

@IBDesignable
class ButtonExtender: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
