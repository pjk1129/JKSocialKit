//
//  BMPromptView.h
//  BaiduHui
//
//  Created by baidu on 15/8/4.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMPromptView : NSObject

+ (void)showPromptInView:(UIView *)superView message:(NSString *)message;
+ (void)showPromptInView:(UIView *)superView message:(NSString *)message duration:(NSTimeInterval)duration;

/**
 * The UIView (e.g., a UIImageView) to be shown when the HUD is in MBProgressHUDModeCustomView.
 * For best results use a 37 by 37 pixel view (so the bounds match the built in indicator bounds).
 */
+ (void)showPromptInView:(UIView *)superView message:(NSString *)message imgName:(NSString *)imgName;
+ (void)showPromptInView:(UIView *)superView
                 message:(NSString *)message
                 imgName:(NSString *)imgName
                duration:(NSTimeInterval)duration;

+ (void)showPromptInView:(UIView *)superView message:(NSString *)message customView:(UIView *)customView;
+ (void)showPromptInView:(UIView *)superView
                 message:(NSString *)message
              customView:(UIView *)customView
                duration:(NSTimeInterval)duration;


@end
