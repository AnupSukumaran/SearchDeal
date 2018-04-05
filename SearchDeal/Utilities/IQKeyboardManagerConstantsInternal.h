//
//  IQKeyboardManagerConstantsInternal.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#ifndef IQKeyboardManagerConstantsInternal_h
#define IQKeyboardManagerConstantsInternal_h


///-----------------------------------
/// @name IQLayoutGuidePosition
///-----------------------------------

/**
 `IQLayoutGuidePositionNone`
 If there are no IQLayoutGuideConstraint associated with viewController
 
 `IQLayoutGuidePositionTop`
 If provided IQLayoutGuideConstraint is associated with with viewController topLayoutGuide
 
 `IQLayoutGuidePositionBottom`
 If provided IQLayoutGuideConstraint is associated with with viewController bottomLayoutGuide
 */
typedef NS_ENUM(NSInteger, IQLayoutGuidePosition) {
    IQLayoutGuidePositionNone,
    IQLayoutGuidePositionTop,
    IQLayoutGuidePositionBottom,
};

#endif
