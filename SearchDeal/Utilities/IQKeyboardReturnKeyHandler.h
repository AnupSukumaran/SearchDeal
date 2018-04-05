//
//  IQKeyboardReturnKeyHandler.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#import "IQKeyboardManagerConstants.h"

#import <Foundation/NSObject.h>
#import <Foundation/NSObjCRuntime.h>

#import <UIKit/UITextField.h>
#import <UIKit/UITextView.h>

@class UITextField,UIView, UIViewController;

/**
 Manages the return key to work like next/done in a view hierarchy.
 */
@interface IQKeyboardReturnKeyHandler : NSObject

///----------------------
/// @name Initializations
///----------------------

/**
 Add all the textFields available in UIViewController's view.
 */
-(nonnull instancetype)initWithViewController:(nullable UIViewController*)controller NS_DESIGNATED_INITIALIZER;

/**
 Unavailable. Please use initWithViewController: or init method
 */
-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

///---------------
/// @name Settings
///---------------

/**
 Delegate of textField/textView.
 */
@property(nullable, nonatomic, weak) id<UITextFieldDelegate,UITextViewDelegate> delegate;

/**
 Set the last textfield return key type. Default is UIReturnKeyDefault.
 */
@property(nonatomic, assign) UIReturnKeyType lastTextFieldReturnKeyType;

///----------------------------------------------
/// @name Registering/Unregistering textFieldView
///----------------------------------------------

/**
 Should pass UITextField/UITextView intance. Assign textFieldView delegate to self, change it's returnKeyType.
 
 @param textFieldView UITextField/UITextView object to register.
 */
-(void)addTextFieldView:(nonnull UIView*)textFieldView;

/**
 Should pass UITextField/UITextView intance. Restore it's textFieldView delegate and it's returnKeyType.

 @param textFieldView UITextField/UITextView object to unregister.
 */
-(void)removeTextFieldView:(nonnull UIView*)textFieldView;

/**
 Add all the UITextField/UITextView responderView's.
 
 @param UIView object to register all it's responder subviews.
 */
-(void)addResponderFromView:(nonnull UIView*)view;

/**
 Remove all the UITextField/UITextView responderView's.
 
 @param UIView object to unregister all it's responder subviews.
 */
-(void)removeResponderFromView:(nonnull UIView*)view;

@end
