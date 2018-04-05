//
//  IQUITextFieldView+Additions.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UIView category for managing UITextField/UITextView
 */

@interface UIView (Additions)

/**
 To set customized distance from keyboard for textField/textView. Can't be less than zero
 */
@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;

@end

///-------------------------------------------
/// @name Custom KeyboardDistanceFromTextField
///-------------------------------------------

/**
 Uses default keyboard distance for textField.
 */
extern CGFloat const kIQUseDefaultKeyboardDistance;
