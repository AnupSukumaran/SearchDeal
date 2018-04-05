//
//  OSColors.swift
//  Carbon Kit Swift
//
//  Created by Quiqinfotech Capitan on 16/04/16.
//  Copyright © 2016 Quiqinfotech Softwares. All rights reserved.
//

/*
 
 
 import MaterialDesignColor
 
 textLabel.textColor = MaterialDesignColor.lightGreen400
 
 */



import UIKit

open class AppColor {
    
    open static let Blue = Hex.colorFromHex("00BFFF")
    open static let White = Hex.colorFromHex("FFFFFF")
    open static let Green1 = Hex.colorFromHex("35B00C")
    open static let Green2 = Hex.colorFromHex("17D8AB")//profile
    open static let Yellow = Hex.colorFromHex("FACA07")
    open static let LightGrey = Hex.colorFromHex("AAAAAA")
    open static let DarkGrey = Hex.colorFromHex("555555")
    open static let DarkGrey1 = Hex.colorFromHex("2D3E50")//profile back
    open static let PrimaryColor = Hex.colorFromHex("E8E9E9")
    open static let Orange = Hex.colorFromHex("4190F0")
    open static let Black = Hex.colorFromHex("000000")
    
    open static let AppGreen = Hex.colorFromHex("43A047")
    open static let AppRed = Hex.colorFromHex("EF5350")
    open static let AppGrey = Hex.colorFromHex("BDBDBD")
    open static let UnReadBlue = Hex.colorFromHex("E3F2FD")
    
    
    open static let AppColorActualPrice = Hex.colorFromHex("19b2e7")
    open static let AppColorDiscountPrice = Hex.colorFromHex("5bad27")
    open static let AppColorOfferPrice = Hex.colorFromHex("d76efa")

       
    
    open static let transparentIndigo900 = Hex.transparentColorFromHex("1A237E",alpha: 0.5)
    open static let transparentBlack = Hex.transparentColorFromHex("919191",alpha: 0.6)
    
    
    
    
    open static let transparenWhite = Hex.transparentColorFromHex("FFFFFF",alpha: 0.0)
    open static let transparentBlack1 = Hex.transparentColorFromHex("000000",alpha: 0.5)
    
    
    
}



open class OSColors {
    
    
    
    class func MyColor(_ colorCode: String)->UIColor{
        
        var colourCode = colorCode
        colourCode = colorCode.replacingOccurrences(of: "#", with: "", options: NSString.CompareOptions.literal, range: nil)
        return Hex.colorFromHex(colourCode)
    }
    
    
    
    /*   RED   */
    
    open static let RED50             = Hex.colorFromHex("FFEBEE")
    open static let RED100            = Hex.colorFromHex("FFCDD2")
    open static let RED200            = Hex.colorFromHex("EF9A9A")
    open static let RED300            = Hex.colorFromHex("E57373")
    open static let RED400            = Hex.colorFromHex("EF5350")
    open static let RED500            = Hex.colorFromHex("F44336")
    open static let RED600            = Hex.colorFromHex("E53935")
    open static let RED700            = Hex.colorFromHex("D32F2F")
    open static let RED800            = Hex.colorFromHex("C62828")
    open static let RED900            = Hex.colorFromHex("B71C1C")
    open static let REDA100           = Hex.colorFromHex("FF8A80")
    open static let REDA200           = Hex.colorFromHex("FF5252")
    open static let REDA400           = Hex.colorFromHex("FF1744")
    open static let REDA700           = Hex.colorFromHex("D50000")
    
    /*   PINK   */
    
    open static let PINK50            = Hex.colorFromHex("FCE4EC")
    open static let PINK100           = Hex.colorFromHex("F8BBD0")
    open static let PINK200           = Hex.colorFromHex("F48FB1")
    open static let PINK300           = Hex.colorFromHex("F06292")
    open static let PINK400           = Hex.colorFromHex("EC407A")
    open static let PINK500           = Hex.colorFromHex("E91E63")
    open static let PINK600           = Hex.colorFromHex("D81B60")
    open static let PINK700           = Hex.colorFromHex("C2185B")
    open static let PINK800           = Hex.colorFromHex("AD1457")
    open static let PINK900           = Hex.colorFromHex("880E4F")
    open static let PINKA100          = Hex.colorFromHex("FF80AB")
    open static let PINKA200          = Hex.colorFromHex("FF4081")
    open static let PINKA400          = Hex.colorFromHex("F50057")
    open static let PINKA700          = Hex.colorFromHex("C51162")
    
    /*   PURPLE   */
    
    open static let PURPLE50          = Hex.colorFromHex("F3E5F5")
    open static let PURPLE100         = Hex.colorFromHex("E1BEE7")
    open static let PURPLE200         = Hex.colorFromHex("CE93D8")
    open static let PURPLE300         = Hex.colorFromHex("BA68C8")
    open static let PURPLE400         = Hex.colorFromHex("AB47BC")
    open static let PURPLE500         = Hex.colorFromHex("9C27B0")
    open static let PURPLE600         = Hex.colorFromHex("8E24AA")
    open static let PURPLE700         = Hex.colorFromHex("7B1FA2")
    open static let PURPLE800         = Hex.colorFromHex("6A1B9A")
    open static let PURPLE900         = Hex.colorFromHex("4A148C")
    open static let PURPLEA100        = Hex.colorFromHex("EA80FC")
    open static let PURPLEA200        = Hex.colorFromHex("E040FB")
    open static let PURPLEA400        = Hex.colorFromHex("D500F9")
    open static let PURPLEA700        = Hex.colorFromHex("AA00FF")
    
    
    /*   DEEPPURPLE   */
    
    open static let DEEPPURPLE        = Hex.colorFromHex("673AB7")
    open static let DEEPPURPLE50      = Hex.colorFromHex("EDE7F6")
    open static let DEEPPURPLE100     = Hex.colorFromHex("D1C4E9")
    open static let DEEPPURPLE200     = Hex.colorFromHex("B39DDB")
    open static let DEEPPURPLE300     = Hex.colorFromHex("9575CD")
    open static let DEEPPURPLE400     = Hex.colorFromHex("7E57C2")
    open static let DEEPPURPLE500     = Hex.colorFromHex("673AB7")
    open static let DEEPPURPLE600     = Hex.colorFromHex("5E35B1")
    open static let DEEPPURPLE700     = Hex.colorFromHex("512DA8")
    open static let DEEPPURPLE800     = Hex.colorFromHex("4527A0")
    open static let DEEPPURPLE900     = Hex.colorFromHex("311B92")
    open static let DEEPPURPLEA100    = Hex.colorFromHex("B388FF")
    open static let DEEPPURPLEA200    = Hex.colorFromHex("7C4DFF")
    open static let DEEPPURPLEA400    = Hex.colorFromHex("651FFF")
    open static let DEEPPURPLEA700    = Hex.colorFromHex("6200EA")
    
    
    /*   INDIGO   */
    
    open static let INDIGO50          = Hex.colorFromHex("E8EAF6")
    open static let INDIGO100         = Hex.colorFromHex("C5CAE9")
    open static let INDIGO200         = Hex.colorFromHex("9FA8DA")
    open static let INDIGO300         = Hex.colorFromHex("7986CB")
    open static let INDIGO400         = Hex.colorFromHex("5C6BC0")
    open static let INDIGO500         = Hex.colorFromHex("3F51B5")
    open static let INDIGO600         = Hex.colorFromHex("3949AB")
    open static let INDIGO700         = Hex.colorFromHex("303F9F")
    open static let INDIGO800         = Hex.colorFromHex("283593")
    open static let INDIGO900         = Hex.colorFromHex("1A237E")
    open static let INDIGOA100        = Hex.colorFromHex("8C9EFF")
    open static let INDIGOA200        = Hex.colorFromHex("536DFE")
    open static let INDIGOA400        = Hex.colorFromHex("3D5AFE")
    open static let INDIGOA700        = Hex.colorFromHex("304FFE")
    
    /*   BLUE   */
    
    open static let BLUE50            = Hex.colorFromHex("E3F2FD")
    open static let BLUE100           = Hex.colorFromHex("BBDEFB")
    open static let BLUE200           = Hex.colorFromHex("90CAF9")
    open static let BLUE300           = Hex.colorFromHex("64B5F6")
    open static let BLUE400           = Hex.colorFromHex("42A5F5")
    open static let BLUE500           = Hex.colorFromHex("2196F3")
    open static let BLUE600           = Hex.colorFromHex("1E88E5")
    open static let BLUE700           = Hex.colorFromHex("1976D2")
    open static let BLUE800           = Hex.colorFromHex("1565C0")
    open static let BLUE900           = Hex.colorFromHex("0D47A1")
    open static let BLUEA100          = Hex.colorFromHex("82B1FF")
    open static let BLUEA200          = Hex.colorFromHex("448AFF")
    open static let BLUEA400          = Hex.colorFromHex("2979FF")
    open static let BLUEA700          = Hex.colorFromHex("2962FF")
    
    /*   LIGHT BLUE   */
    
    open static let LIGHTBLUE50       = Hex.colorFromHex("E1F5FE")
    open static let LIGHTBLUE100      = Hex.colorFromHex("B3E5FC")
    open static let LIGHTBLUE200      = Hex.colorFromHex("81D4FA")
    open static let LIGHTBLUE300      = Hex.colorFromHex("4FC3F7")
    open static let LIGHTBLUE400      = Hex.colorFromHex("29B6F6")
    open static let LIGHTBLUE500      = Hex.colorFromHex("03A9F4")
    open static let LIGHTBLUE600      = Hex.colorFromHex("039BE5")
    open static let LIGHTBLUE700      = Hex.colorFromHex("0288D1")
    open static let LIGHTBLUE800      = Hex.colorFromHex("0277BD")
    open static let LIGHTBLUE900      = Hex.colorFromHex("01579B")
    open static let LIGHTBLUEA100     = Hex.colorFromHex("80D8FF")
    open static let LIGHTBLUEA200     = Hex.colorFromHex("40C4FF")
    open static let LIGHTBLUEA400     = Hex.colorFromHex("00B0FF")
    open static let LIGHTBLUEA700     = Hex.colorFromHex("0091EA")
    
    /*   CYAN   */
    
    open static let CYAN50            = Hex.colorFromHex("E0F7FA")
    open static let CYAN100           = Hex.colorFromHex("B2EBF2")
    open static let CYAN200           = Hex.colorFromHex("80DEEA")
    open static let CYAN300           = Hex.colorFromHex("4DD0E1")
    open static let CYAN400           = Hex.colorFromHex("26C6DA")
    open static let CYAN500           = Hex.colorFromHex("00BCD4")
    open static let CYAN600           = Hex.colorFromHex("00ACC1")
    open static let CYAN700           = Hex.colorFromHex("0097A7")
    open static let CYAN800           = Hex.colorFromHex("00838F")
    open static let CYAN900           = Hex.colorFromHex("6064")
    open static let CYANA100          = Hex.colorFromHex("84FFFF")
    open static let CYANA200          = Hex.colorFromHex("18FFFF")
    open static let CYANA400          = Hex.colorFromHex("00E5FF")
    open static let CYANA700          = Hex.colorFromHex("00B8D4")
    
    /*   TEAL   */
    
    open static let TEAL50            = Hex.colorFromHex("E0F2F1")
    open static let TEAL100           = Hex.colorFromHex("B2DFDB")
    open static let TEAL200           = Hex.colorFromHex("80CBC4")
    open static let TEAL300           = Hex.colorFromHex("4DB6AC")
    open static let TEAL400           = Hex.colorFromHex("26A69A")
    open static let TEAL500           = Hex.colorFromHex("9688")
    open static let TEAL600           = Hex.colorFromHex("00897B")
    open static let TEAL700           = Hex.colorFromHex("00796B")
    open static let TEAL800           = Hex.colorFromHex("00695C")
    open static let TEAL900           = Hex.colorFromHex("004D40")
    open static let TEALA100          = Hex.colorFromHex("A7FFEB")
    open static let TEALA200          = Hex.colorFromHex("64FFDA")
    open static let TEALA400          = Hex.colorFromHex("1DE9B6")
    open static let TEALA700          = Hex.colorFromHex("00BFA5")
    
    /*   GREEN   */
    
    open static let GREEN50           = Hex.colorFromHex("E8F5E9")
    open static let GREEN100          = Hex.colorFromHex("C8E6C9")
    open static let GREEN200          = Hex.colorFromHex("A5D6A7")
    open static let GREEN300          = Hex.colorFromHex("81C784")
    open static let GREEN400          = Hex.colorFromHex("66BB6A")
    open static let GREEN500          = Hex.colorFromHex("4CAF50")
    open static let GREEN600          = Hex.colorFromHex("43A047")
    open static let GREEN700          = Hex.colorFromHex("388E3C")
    open static let GREEN800          = Hex.colorFromHex("2E7D32")
    open static let GREEN900          = Hex.colorFromHex("1B5E20")
    open static let GREENA100         = Hex.colorFromHex("B9F6CA")
    open static let GREENA200         = Hex.colorFromHex("69F0AE")
    open static let GREENA400         = Hex.colorFromHex("0.00E+00")
    open static let GREENA700         = Hex.colorFromHex("00C853")
    
    /*   LIGHT GREEN   */
    
    open static let LIGHTGREEN50      = Hex.colorFromHex("F1F8E9")
    open static let LIGHTGREEN100     = Hex.colorFromHex("DCEDC8")
    open static let LIGHTGREEN200     = Hex.colorFromHex("C5E1A5")
    open static let LIGHTGREEN300     = Hex.colorFromHex("AED581")
    open static let LIGHTGREEN400     = Hex.colorFromHex("9CCC65")
    open static let LIGHTGREEN500     = Hex.colorFromHex("8BC34A")
    open static let LIGHTGREEN600     = Hex.colorFromHex("7CB342")
    open static let LIGHTGREEN700     = Hex.colorFromHex("689F38")
    open static let LIGHTGREEN800     = Hex.colorFromHex("558B2F")
    open static let LIGHTGREEN900     = Hex.colorFromHex("33691E")
    open static let LIGHTGREENA100    = Hex.colorFromHex("CCFF90")
    open static let LIGHTGREENA200    = Hex.colorFromHex("B2FF59")
    open static let LIGHTGREENA400    = Hex.colorFromHex("76FF03")
    open static let LIGHTGREENA700    = Hex.colorFromHex("64DD17")
    
    /*   LIME   */
    
    open static let LIME50            = Hex.colorFromHex("F9FBE7")
    open static let LIME100           = Hex.colorFromHex("F0F4C3")
    open static let LIME200           = Hex.colorFromHex("E6EE9C")
    open static let LIME300           = Hex.colorFromHex("DCE775")
    open static let LIME400           = Hex.colorFromHex("D4E157")
    open static let LIME500           = Hex.colorFromHex("CDDC39")
    open static let LIME600           = Hex.colorFromHex("C0CA33")
    open static let LIME700           = Hex.colorFromHex("AFB42B")
    open static let LIME800           = Hex.colorFromHex("9E9D24")
    open static let LIME900           = Hex.colorFromHex("827717")
    open static let LIMEA100          = Hex.colorFromHex("F4FF81")
    open static let LIMEA200          = Hex.colorFromHex("EEFF41")
    open static let LIMEA400          = Hex.colorFromHex("C6FF00")
    open static let LIMEA700          = Hex.colorFromHex("AEEA00")
    
    /*   YELLOW   */
    
    open static let YELLOW50          = Hex.colorFromHex("FFFDE7")
    open static let YELLOW100         = Hex.colorFromHex("FFF9C4")
    open static let YELLOW200         = Hex.colorFromHex("FFF59D")
    open static let YELLOW300         = Hex.colorFromHex("FFF176")
    open static let YELLOW400         = Hex.colorFromHex("FFEE58")
    open static let YELLOW500         = Hex.colorFromHex("FFEB3B")
    open static let YELLOW600         = Hex.colorFromHex("FDD835")
    open static let YELLOW700         = Hex.colorFromHex("FBC02D")
    open static let YELLOW800         = Hex.colorFromHex("F9A825")
    open static let YELLOW900         = Hex.colorFromHex("F57F17")
    open static let YELLOWA100        = Hex.colorFromHex("FFFF8D")
    open static let YELLOWA200        = Hex.colorFromHex("FFFF00")
    open static let YELLOWA400        = Hex.colorFromHex("FFEA00")
    open static let YELLOWA700        = Hex.colorFromHex("FFD600")
    
    /*   AMBER   */
    
    open static let AMEBER50          = Hex.colorFromHex("FFF8E1")
    open static let AMEBER100         = Hex.colorFromHex("FFECB3")
    open static let AMEBER200         = Hex.colorFromHex("FFE082")
    open static let AMEBER300         = Hex.colorFromHex("FFD54F")
    open static let AMEBER400         = Hex.colorFromHex("FFCA28")
    open static let AMEBER500         = Hex.colorFromHex("FFC107")
    open static let AMEBER600         = Hex.colorFromHex("FFB300")
    open static let AMEBER700         = Hex.colorFromHex("FFA000")
    open static let AMEBER800         = Hex.colorFromHex("FF8F00")
    open static let AMEBER900         = Hex.colorFromHex("FF6F00")
    open static let AMEBERA100        = Hex.colorFromHex("FFE57F")
    open static let AMEBERA200        = Hex.colorFromHex("FFD740")
    open static let AMEBERA400        = Hex.colorFromHex("FFC400")
    open static let AMEBERA700        = Hex.colorFromHex("FFAB00")
    
    /*   ORANGE   */
    
    open static let ORANGE50          = Hex.colorFromHex("FFF3E0")
    open static let ORANGE100         = Hex.colorFromHex("FFE0B2")
    open static let ORANGE200         = Hex.colorFromHex("FFCC80")
    open static let ORANGE300         = Hex.colorFromHex("FFB74D")
    open static let ORANGE400         = Hex.colorFromHex("FFA726")
    open static let ORANGE500         = Hex.colorFromHex("FF9800")
    open static let ORANGE600         = Hex.colorFromHex("FB8C00")
    open static let ORANGE700         = Hex.colorFromHex("F57C00")
    open static let ORANGE800         = Hex.colorFromHex("EF6C00")
    open static let ORANGE900         = Hex.colorFromHex("E65100")
    open static let ORANGEA100        = Hex.colorFromHex("FFD180")
    open static let ORANGEA200        = Hex.colorFromHex("FFAB40")
    open static let ORANGEA400        = Hex.colorFromHex("FF9100")
    open static let ORANGEA700        = Hex.colorFromHex("FF6D00")
    
    /*   DEEP ORANGE   */
    
    open static let DEEPORANGE50      = Hex.colorFromHex("FBE9E7")
    open static let DEEPORANGE100     = Hex.colorFromHex("FFCCBC")
    open static let DEEPORANGE200     = Hex.colorFromHex("FFAB91")
    open static let DEEPORANGE300     = Hex.colorFromHex("FF8A65")
    open static let DEEPORANGE400     = Hex.colorFromHex("FF7043")
    open static let DEEPORANGE500     = Hex.colorFromHex("FF5722")
    open static let DEEPORANGE600     = Hex.colorFromHex("F4511E")
    open static let DEEPORANGE700     = Hex.colorFromHex("E64A19")
    open static let DEEPORANGE800     = Hex.colorFromHex("D84315")
    open static let DEEPORANGE900     = Hex.colorFromHex("BF360C")
    open static let DEEPORANGEA100    = Hex.colorFromHex("FF9E80")
    open static let DEEPORANGEA200    = Hex.colorFromHex("FF6E40")
    open static let DEEPORANGEA400    = Hex.colorFromHex("FF3D00")
    open static let DEEPORANGEA700    = Hex.colorFromHex("DD2C00")
    
    /*   BROWN   */
    
    open static let BROWN50           = Hex.colorFromHex("EFEBE9")
    open static let BROWN100          = Hex.colorFromHex("D7CCC8")
    open static let BROWN200          = Hex.colorFromHex("BCAAA4")
    open static let BROWN300          = Hex.colorFromHex("A1887F")
    open static let BROWN400          = Hex.colorFromHex("8D6E63")
    open static let BROWN500          = Hex.colorFromHex("795548")
    open static let BROWN600          = Hex.colorFromHex("6D4C41")
    open static let BROWN700          = Hex.colorFromHex("5D4037")
    open static let BROWN800          = Hex.colorFromHex("4E342E")
    open static let BROWN900          = Hex.colorFromHex("3E2723")
    
    /*   GREY   */
    
    open static let GREY50            = Hex.colorFromHex("FAFAFA")
    open static let GREY100           = Hex.colorFromHex("F5F5F5")
    open static let GREY200           = Hex.colorFromHex("EEEEEE")
    open static let GREY300           = Hex.colorFromHex("E0E0E0")
    open static let GREY400           = Hex.colorFromHex("BDBDBD")
    open static let GREY500           = Hex.colorFromHex("9E9E9E")
    open static let GREY600           = Hex.colorFromHex("757575")
    open static let GREY700           = Hex.colorFromHex("616161")
    open static let GREY800           = Hex.colorFromHex("424242")
    open static let GREY900           = Hex.colorFromHex("212121")
    
    /*   BLUE GREY   */
    
    open static let BLUEGREY50        = Hex.colorFromHex("ECEFF1")
    open static let BLUEGREY100       = Hex.colorFromHex("CFD8DC")
    open static let BLUEGREY200       = Hex.colorFromHex("B0BEC5")
    open static let BLUEGREY300       = Hex.colorFromHex("90A4AE")
    open static let BLUEGREY400       = Hex.colorFromHex("78909C")
    open static let BLUEGREY500       = Hex.colorFromHex("607D8B")
    open static let BLUEGREY600       = Hex.colorFromHex("546E7A")
    open static let BLUEGREY700       = Hex.colorFromHex("455A64")
    open static let BLUEGREY800       = Hex.colorFromHex("37474F")
    open static let BLUEGREY900       = Hex.colorFromHex("263238")
}

private class Hex {
    
    
    fileprivate class func colorFromHex(_ colorCode: String) -> UIColor {
        let scanner = Scanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    fileprivate class func transparentColorFromHex(_ colorCode: String,alpha:CGFloat) -> UIColor {
        let scanner = Scanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
}
