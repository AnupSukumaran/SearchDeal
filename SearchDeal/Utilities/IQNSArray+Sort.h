//
//  NSArray+Sort.h
//  nisse
//
//  Created by don_Quiqinfotech_softwares on 10/04/16.
//  Copyright © 2016 nissenotes. All rights reserved.
//

#import <Foundation/NSArray.h>

/**
 UIView.subviews sorting category.
 */
@interface NSArray (IQ_NSArray_Sort)

///--------------
/// @name Sorting
///--------------

/**
 Returns the array by sorting the UIView's by their tag property.
 */
- (nonnull NSArray*)sortedArrayByTag;

/**
 Returns the array by sorting the UIView's by their tag property.
 */
- (nonnull NSArray*)sortedArrayByPosition;

@end
