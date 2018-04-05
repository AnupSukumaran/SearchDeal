//
//  IQUIScrollView+Additions.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIScrollView (Additions)

/**
 Restore scrollViewContentOffset when resigning from scrollView. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldRestoreScrollViewContentOffset;


@end
