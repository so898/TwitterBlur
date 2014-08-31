//
//  UIWindow+KLSnapShot.m
//  FacePiapiapia
//
//  Created by Bill Cheng on 14-8-7.
//  Copyright (c) 2014年 R3 Studio. All rights reserved.
//

#import "UIWindow+KLSnapShot.h"

@implementation UIWindow (KLSnapShot)

#pragma mark - Public

- (UIViewController *)kl_viewControllerForStatusBarStyle
{
    UIViewController *currentViewController = [self currentViewController];
    
    while ([currentViewController childViewControllerForStatusBarStyle]) {
        currentViewController = [currentViewController childViewControllerForStatusBarStyle];
    }
    return currentViewController;
}

- (UIViewController *)kl_viewControllerForStatusBarHidden
{
    UIViewController *currentViewController = [self currentViewController];
    
    while ([currentViewController childViewControllerForStatusBarHidden]) {
        currentViewController = [currentViewController childViewControllerForStatusBarHidden];
    }
    return currentViewController;
}

- (UIImage *)kl_snapshot
{
    // source (under MIT license): https://github.com/shinydevelopment/SDScreenshotCapture/blob/master/SDScreenshotCapture/SDScreenshotCapture.m#L35
    
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x, self.center.y);
    CGContextConcatCTM(context, self.transform);
    CGContextTranslateCTM(context, -self.bounds.size.width * self.layer.anchorPoint.x, -self.bounds.size.height * self.layer.anchorPoint.y);
    
    // correct for the screen orientation
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        CGContextRotateCTM(context, (CGFloat)M_PI_2);
        CGContextTranslateCTM(context, 0, -imageSize.width);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        CGContextRotateCTM(context, (CGFloat)-M_PI_2);
        CGContextTranslateCTM(context, -imageSize.height, 0);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGContextRotateCTM(context, (CGFloat)M_PI);
        CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
    }
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Private

- (UIViewController *)currentViewController
{
    UIViewController *viewController = self.rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

@end

