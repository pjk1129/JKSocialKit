//
//  BMWeiboApiManager.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboSDK/WeiboSDK.h>
#import "BMSocialShareContent.h"

@protocol BMWeiboApiManagerDelegate <NSObject>
@optional
- (void)wbShareResponseDidSuccess:(BOOL)success;

@end

@interface BMWeiboApiManager : NSObject

- (instancetype)initWithDelegate:(id<BMWeiboApiManagerDelegate>)delegate;

-(BOOL)handleOpenURL:(NSURL *)url;
- (void)registerSinaApp:(NSString *)appid;

- (void)shareToWeiboWithShareContent:(BMSocialShareContent *)content;

@end
