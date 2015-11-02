//
//  BMSocialShareManager.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/28.
//  Copyright © 2015年 baidu. All rights reserved.
//

/*
 示例：
 
 BMSocialShareContent  *content = [BMSocialShareContent shareContentWithImage:[UIImage imageNamed:@"mall_logo.png"] title:@"百度Mall" desc:@"百度Mall" content:@"百度Mall" webUrl:@"http://mall.baidu.com" type:kSocialShareContentTypeMedia platform:kSocialPlatformTypeSinaWB compressed:NO];
 [[BMSocialShareManager shared] shareToSocialPlatformWithShareContent:content compBlock:^(NSString *message, BOOL success) {
 if (message) {
 [BMPromptView showPromptInView:self.view message:message];
 }
 
 }];
 
 */

#import <Foundation/Foundation.h>
#import "BMWXApiManager.h"
#import "BMQQShareManager.h"
#import "BMWeiboApiManager.h"

FOUNDATION_EXTERN NSString * const kBaiduSocialShareSINAAPPID;
FOUNDATION_EXTERN NSString * const kBaiduSocialShareQQAPPID;
FOUNDATION_EXTERN NSString * const kBaiduSocialShareWXAPPID;

typedef void (^ShareDidCompletedBlock)(NSString *message, BOOL success);

@interface BMSocialShareManager : NSObject

+ (BMSocialShareManager *)shared;

- (void)registerWeChatApp:(NSString *)appid;
- (void)registerSinaWBApp:(NSString *)appid;
- (void)registerAppQQConnect:(NSString *)appid;

-(BOOL)handleOpenURL:(NSURL *)url;

- (void)shareToSocialPlatformWithShareContent:(BMSocialShareContent *)content
                                    compBlock:(ShareDidCompletedBlock)block;

@end
