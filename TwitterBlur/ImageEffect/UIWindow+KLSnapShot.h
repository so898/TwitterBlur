//
//  UIWindow+KLSnapShot.h
//  FacePiapiapia
//
//  Created by Bill Cheng on 14-8-7.
//  Copyright (c) 2014年 R3 Studio. All rights reserved.
//
// Original source: https://github.com/Sumi-Interactive/SIAlertView/blob/master/SIAlertView/UIWindow%2BSIUtils.h

#import <Foundation/Foundation.h>

@interface UIWindow (KLSnapShot)

- (UIViewController *)kl_viewControllerForStatusBarStyle;
- (UIViewController *)kl_viewControllerForStatusBarHidden;
- (UIImage *)kl_snapshot;

@end
