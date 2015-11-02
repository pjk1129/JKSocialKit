//
//  BMSocialShareManager.m
//  BaiduMall
//
//  Created by JK.PENG on 15/10/28.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "BMSocialShareManager.h"

NSString * const kBaiduSocialShareSINAAPPID             = @"2213820015";
NSString * const kBaiduSocialShareQQAPPID               = @"1104573782";
NSString * const kBaiduSocialShareWXAPPID               = @"wx4dc972882618d1a5";

@interface BMSocialShareManager()<BMWXApiManagerDelegate,BMQQShareManagerDelegate,BMWeiboApiManagerDelegate>{
    ShareDidCompletedBlock     _sinaShareBlock;
    ShareDidCompletedBlock     _wechatShareBlock;
    ShareDidCompletedBlock     _qqShareBlock;
}
@property (nonatomic, strong) BMWXApiManager      *wxApiManager;
@property (nonatomic, strong) BMQQShareManager    *qqManager;
@property (nonatomic, strong) BMWeiboApiManager   *wbManager;

@end

@implementation BMSocialShareManager

+ (BMSocialShareManager *)shared
{
    static BMSocialShareManager   *socialShareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socialShareManager = [[BMSocialShareManager alloc] init];
    });
    return socialShareManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)registerWeChatApp:(NSString *)appid{
    [self.wxApiManager registerWeChatApp:appid];
}

- (void)registerSinaWBApp:(NSString *)appid{
    [self.wbManager registerSinaApp:appid];
}

- (void)registerAppQQConnect:(NSString *)appid{
    [self.qqManager registerQQApp:appid];
}

-(BOOL)handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:kBaiduSocialShareWXAPPID]) {
        return [self.wxApiManager handleOpenURL:url];
    }
    
    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"tencent%@", kBaiduSocialShareQQAPPID]]) {
        if (_qqShareBlock) {
            return [self.qqManager handleOpenURL:url];
        }
    }
    
    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"wb%@", kBaiduSocialShareSINAAPPID]]) {
        if (_sinaShareBlock) {
            return [self.wbManager handleOpenURL:url];
        }
    }
    return YES;
}

- (void)shareToSocialPlatformWithShareContent:(BMSocialShareContent *)content
                                    compBlock:(ShareDidCompletedBlock)block{
    if (content.socialPlatform == kSocialPlatformTypeSinaWB) {
        _sinaShareBlock = block;
        
        if (![WeiboSDK isWeiboAppInstalled]) {
            [self wbShareDidFailed:@"您未安装微博客户端"];
            return;
        }
        
        if (![WeiboSDK isWeiboAppInstalled]
            ||![WeiboSDK isCanShareInWeiboAPP]) {
            [self wbShareDidFailed:@"您不可以通过微博客户端分享"];
            return;
        }
        
        [self.wbManager shareToWeiboWithShareContent:content];
        
    }else if (content.socialPlatform == kSocialPlatformTypeWXSession
              || content.socialPlatform == kSocialPlatformTypeWXTimeline){
        
        _wechatShareBlock = block;
        if (![WXApi isWXAppInstalled]) {
            [self weChatShareDidFailed:@"您的手机未安装微信"];
            return;
        }
        
        [self.wxApiManager shareToWXWithShareContent:content];
   
    }else if (content.socialPlatform == kSocialPlatformTypeQQ
              || content.socialPlatform == kSocialPlatformTypeQZone){
        _qqShareBlock = block;
        if (![QQApiInterface isQQInstalled]) {
            [self qqShareDidFailed:@"您的设备未安装QQ"];
            return;
        }
       
        [self.qqManager shareToQQPlatformWithShareContent:content];
        
    }
}

#pragma mark - BMWXApiManagerDelegate
- (void)wxShareResponseDidSuccess:(BOOL)success{
    if (success) {
        [self weChatShareDidSuccess];
    }else{
        [self weChatShareDidFailed:@"分享失败"];
    }
}

- (void)weChatShareDidSuccess{
    if (_wechatShareBlock) {
        _wechatShareBlock(@"分享成功",YES);
    }
    _wechatShareBlock = nil;
}

- (void)weChatShareDidFailed:(NSString *)errorMsg{
    if (_wechatShareBlock) {
        _wechatShareBlock(errorMsg,NO);
    }
    _wechatShareBlock = nil;
}

#pragma mark - BMQQShareManagerDelegate
- (void)qqShareResponseDidSuccess:(BOOL)success
{
    if (success) {
        [self qqShareDidSuccess];
    }else{
        [self qqShareDidFailed:@"分享失败"];
    }
}

- (void)qqShareDidSuccess{
    if (_qqShareBlock) {
        _qqShareBlock(@"分享成功",YES);
    }
    _qqShareBlock = nil;
}

- (void)qqShareDidFailed:(NSString *)errorMsg{
    if (_qqShareBlock) {
        _qqShareBlock(errorMsg,NO);
    }
    _qqShareBlock = nil;
}


#pragma mark - BMWeiboApiManagerDelegate
- (void)wbShareResponseDidSuccess:(BOOL)success{
    if (success) {
        [self wbShareDidSuccess];
    }else{
        [self wbShareDidFailed:@"分享失败"];
    }
}

- (void)wbShareDidSuccess{
    if (_sinaShareBlock) {
        _sinaShareBlock(@"分享成功",YES);
    }
    _sinaShareBlock = nil;
}

- (void)wbShareDidFailed:(NSString *)errorMsg{
    if (_sinaShareBlock) {
        _sinaShareBlock(errorMsg,NO);
    }
    _sinaShareBlock = nil;
}

#pragma mark - getter
- (BMWXApiManager *)wxApiManager{
    if (!_wxApiManager) {
        _wxApiManager = [[BMWXApiManager alloc] initWithDelegate:self];
    }
    return _wxApiManager;
}

- (BMQQShareManager *)qqManager{
    if (!_qqManager) {
        _qqManager = [[BMQQShareManager alloc] initWithDelegate:self];
    }
    return _qqManager;
}

- (BMWeiboApiManager *)wbManager{
    if (!_wbManager) {
        _wbManager = [[BMWeiboApiManager alloc] initWithDelegate:self];
    }
    return _wbManager;
}


@end
