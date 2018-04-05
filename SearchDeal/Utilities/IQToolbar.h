//
//  IQToolbar.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#import <UIKit/UIToolbar.h>

/**
 IQToolbar for IQKeyboardManager.
 */
@interface IQToolbar : UIToolbar <UIInputViewAudioFeedback>

/**
 Title font for toolbar.
 */
@property(nullable, nonatomic, strong) UIFont *titleFont;

/**
 Toolbar title
 */
@property(nullable, nonatomic, strong) NSString *title;

@end

