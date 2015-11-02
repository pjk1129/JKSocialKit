//
//  BMWXApiManager.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "BMSocialShareContent.h"

@protocol BMWXApiManagerDelegate <NSObject>
@optional
- (void)wxShareResponseDidSuccess:(BOOL)success;

@end

@interface BMWXApiManager : NSObject

- (instancetype)initWithDelegate:(id<BMWXApiManagerDelegate>)delegate;

-(BOOL)handleOpenURL:(NSURL *)url;
- (void)registerWeChatApp:(NSString *)appid;

- (void)shareToWXWithShareContent:(BMSocialShareContent *)content;

@end
