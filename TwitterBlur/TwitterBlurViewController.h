//
//  TwitterBlurViewController.h
//  TwitterBlur
//
//  Created by Bill Cheng on 14-9-1.
//  Copyright (c) 2014年 R3 Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterBlurViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIView *expandView, *expandDetail, *ageStatus;
    UIImageView *avatarImageView, *expandZoomImageView, *blur1, *blur2, *blur3, *blur4;
    UITableView *mainTable;
    UILabel *name, *ageLabel;
    NSArray *array;
}

@end
