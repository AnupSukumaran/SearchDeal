//
//  IQUIViewController+Additions.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additions)

/**
 Top/Bottom Layout constraint which help library to manage keyboardTextField distance
 */
@property(nullable, nonatomic, strong) IBOutlet NSLayoutConstraint *IQLayoutGuideConstraint;

@end
