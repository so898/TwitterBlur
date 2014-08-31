//
//  TwitterBlurViewController.m
//  TwitterBlur
//
//  Created by Bill Cheng on 14-9-1.
//  Copyright (c) 2014年 R3 Studio. All rights reserved.
//

#import "TwitterBlurViewController.h"
#import "UIImage+ImageEffects.h"

#define Height ([[UIScreen mainScreen] bounds].size.height - 20)


@interface TwitterBlurViewController ()

@end

@implementation TwitterBlurViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"模拟Twitter";
        
        expandView = [UIView new];
        expandView.frame = CGRectMake(0, -160, 320, 160);
        expandView.layer.masksToBounds = YES;
        
        expandZoomImageView = [UIImageView new];
        expandZoomImageView.frame = CGRectMake(0, -15, 320, 190);
        expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
        [expandView addSubview:expandZoomImageView];
        
        blur1 = [UIImageView new];
        blur1.frame = CGRectMake(0, -15, 320, 190);
        blur1.contentMode = UIViewContentModeScaleAspectFill;
        [expandView addSubview:blur1];
        blur1.alpha = 0;
        
        blur2 = [UIImageView new];
        blur2.frame = CGRectMake(0, -15, 320, 190);
        blur2.contentMode = UIViewContentModeScaleAspectFill;
        [expandView addSubview:blur2];
        blur2.alpha = 0;
        
        blur3 = [UIImageView new];
        blur3.frame = CGRectMake(0, -15, 320, 190);
        blur3.contentMode = UIViewContentModeScaleAspectFill;
        [expandView addSubview:blur3];
        blur3.alpha = 0;
        
        blur4 = [UIImageView new];
        blur4.frame = CGRectMake(0, -15, 320, 190);
        blur4.contentMode = UIViewContentModeScaleAspectFill;
        [expandView addSubview:blur4];
        blur4.alpha = 0;
        
        expandDetail = [UIView new];
        expandDetail.frame = CGRectMake(0, 0, 320, 160);
        expandDetail.backgroundColor = [UIColor clearColor];
        [expandView addSubview:expandDetail];
        
        mainTable = [UITableView new];
        mainTable.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
        mainTable.delegate = self;
        mainTable.dataSource = self;
        mainTable.frame = CGRectMake(0, 40, 320, Height - 40);
        mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        mainTable.tableFooterView = [UIView new];
        [self.view addSubview:mainTable];
        
        [mainTable addSubview:expandView];
        
        avatarImageView = [UIImageView new];
        avatarImageView.frame = CGRectMake(14, 90, 60, 60);
        avatarImageView.layer.cornerRadius = 30;
        avatarImageView.layer.masksToBounds = YES;
        avatarImageView.backgroundColor = [UIColor grayColor];
        avatarImageView.userInteractionEnabled = YES;
        avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [expandDetail addSubview:avatarImageView];
        
        name = [UILabel new];
        name.frame = CGRectMake(86, 160 - 48 - 17 + 3, 200, 18);
        name.font = [UIFont boldSystemFontOfSize:16];
        name.backgroundColor = [UIColor clearColor];
        name.textColor = [UIColor whiteColor];
        [expandDetail addSubview:name];
        
        ageStatus = [UIView new];
        ageStatus.frame = CGRectMake(87, 160 - 48 - 17 + 22 + 8, 31, 14);
        ageStatus.layer.cornerRadius = 6.5f;
        ageStatus.layer.masksToBounds = YES;
        [expandDetail addSubview:ageStatus];
        
        ageLabel = [UILabel new];
        ageLabel.frame = CGRectMake(2, 1, 27, 12);
        ageLabel.textAlignment = NSTextAlignmentCenter;
        ageLabel.font = [UIFont systemFontOfSize:11];
        ageLabel.backgroundColor = [UIColor clearColor];
        ageLabel.textColor = [UIColor whiteColor];
        [ageStatus addSubview:ageLabel];
        
        UIImage *backg = [UIImage imageNamed:@"20140807081131763.jpg"];
        
        expandZoomImageView.image = backg;
        avatarImageView.image = [UIImage imageNamed:@"koala.jpg"];
        name.text = @"so898";
        array = @[@"一只死掉的考拉。", @"This koala is dead."];
        
        ageStatus.backgroundColor = [UIColor colorWithRed:((float)66/255) green:((float)152/255) blue:((float)248/255) alpha:1.0f];
        ageLabel.text = @"♂ 23";
        
        blur1.image = [backg kl_applyBlurWithRadius:4 tintColor:[UIColor colorWithWhite:0 alpha:0.1] saturationDeltaFactor:1.0 maskImage:nil];
        blur2.image = [backg kl_applyBlurWithRadius:8 tintColor:[UIColor colorWithWhite:0 alpha:0.1] saturationDeltaFactor:0.75 maskImage:nil];
        blur3.image = [backg kl_applyBlurWithRadius:12 tintColor:[UIColor colorWithWhite:0 alpha:0.1] saturationDeltaFactor:0.5 maskImage:nil];
        blur4.image = [backg kl_applyBlurWithRadius:16 tintColor:[UIColor colorWithWhite:0 alpha:0.1] saturationDeltaFactor:0 maskImage:nil];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[array objectAtIndex:indexPath.row]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -160) {
        CGRect f = expandView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        expandView.frame = f;
        
        expandDetail.frame = CGRectMake(0, f.size.height - 160, 320, 160);
        
        CGRect fx = expandZoomImageView.frame;
        fx.origin.y = (yOffset > -175 ? -(yOffset + 160 + 30) / 2 : 0);
        if (fx.origin.y < 0){
            fx.size.height = 190;
            blur1.alpha = 0;
            blur2.alpha = 0;
            blur3.alpha = 0;
            blur4.alpha = 0;
        } else {
            fx.size.height = -yOffset;
            blur1.alpha = (fx.size.height - 190) / 32;
            blur2.alpha = (fx.size.height - 190 - 32) / 32;
            blur3.alpha = (fx.size.height - 190 - 64) / 32;
            blur4.alpha = (fx.size.height - 190 - 96) / 32;
        }
        expandZoomImageView.frame = fx;
        blur1.frame = fx;
        blur2.frame = fx;
        blur3.frame = fx;
        blur4.frame = fx;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
