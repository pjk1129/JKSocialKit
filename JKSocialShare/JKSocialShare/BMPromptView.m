//
//  BMPromptView.m
//  BaiduHui
//
//  Created by baidu on 15/8/4.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BMPromptView.h"
#import "MBProgressHUD.h"

@implementation BMPromptView

+ (void)showPromptInView:(UIView *)superView message:(NSString *)message
{
    [self showPromptInView:superView message:message duration:1.0];
}

+ (void)showPromptInView:(UIView *)superView message:(NSString *)message duration:(NSTimeInterval)duration;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.cornerRadius = 5.f;
    hud.removeFromSuperViewOnHide = YES;
    [superView bringSubviewToFront:hud];
    [hud hide:YES afterDelay:duration>0?duration:1.0f];
}

+ (void)showPromptInView:(UIView *)superView message:(NSString *)message imgName:(NSString *)imgName
{
    [self showPromptInView:superView message:message imgName:imgName duration:1.0];
}

+ (void)showPromptInView:(UIView *)superView
                 message:(NSString *)message
                 imgName:(NSString *)imgName
                duration:(NSTimeInterval)duration
{
    UIImage *image = [UIImage imageNamed:imgName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = image;
    [self showPromptInView:superView
                   message:message
                customView:imageView
                  duration:duration];
}

+ (void)showPromptInView:(UIView *)superView message:(NSString *)message customView:(UIView *)customView
{
    [self showPromptInView:superView message:message customView:customView duration:1.0];
}

+ (void)showPromptInView:(UIView *)superView
                 message:(NSString *)message
              customView:(UIView *)customView
                duration:(NSTimeInterval)duration
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(110, 80);
    hud.cornerRadius = 5.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = customView;
    hud.customView.center = superView.center;
    hud.labelText = message;
    hud.margin = 10.f;
    [superView bringSubviewToFront:hud];

    [hud hide:YES afterDelay:duration>0?duration:1.0f];
}

@end
