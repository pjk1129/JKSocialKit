//
//  BMQQShareManager.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "TencentOpenAPI/QQApiInterface.h"
#import "BMSocialShareContent.h"

@protocol BMQQShareManagerDelegate <NSObject>
@optional
- (void)qqShareResponseDidSuccess:(BOOL)success;

@end

@interface BMQQShareManager : NSObject

- (instancetype)initWithDelegate:(id<BMQQShareManagerDelegate>)delegate;

-(BOOL)handleOpenURL:(NSURL *)url;
- (void)registerQQApp:(NSString *)appid;

- (void)shareToQQPlatformWithShareContent:(BMSocialShareContent *)content;

@end
