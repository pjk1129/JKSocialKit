//
//  BMWeiboApiManager.m
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "BMWeiboApiManager.h"

@interface BMWeiboApiManager()<WeiboSDKDelegate>

@property (nonatomic, weak) id<BMWeiboApiManagerDelegate>  wbDelegate;

@end

@implementation BMWeiboApiManager

- (instancetype)initWithDelegate:(id<BMWeiboApiManagerDelegate>)delegate{
    self = [super init];
    if (self) {
        self.wbDelegate = delegate;
    }
    return self;
}


-(BOOL)handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)registerSinaApp:(NSString *)appid{
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:appid];
}

- (void)shareToWeiboWithShareContent:(BMSocialShareContent *)content
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = [NSString stringWithFormat:@"%@", content.shareContent];
    
    if (content.contentType == kSocialShareContentTypeMedia) {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"百度Mall";
        webpage.title = content.shareTitle;
        webpage.description = content.shareDesc;
        UIImage  *img = [PUUtil getThumbImage:content.thumbImage maxSize:16];
        webpage.thumbnailData = UIImageJPEGRepresentation(img,1);
        webpage.webpageUrl = content.shareURL;
        message.mediaObject = webpage;
    }else if (content.contentType == kSocialShareContentTypeImage){
        WBImageObject *imgObject = [WBImageObject object];
        imgObject.imageData = UIImagePNGRepresentation(content.thumbImage);
        message.imageObject = imgObject;
    }
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        if ([_wbDelegate respondsToSelector:@selector(wbShareResponseDidSuccess:)]) {
            [_wbDelegate wbShareResponseDidSuccess:(response.statusCode==WeiboSDKResponseStatusCodeSuccess)];
        }
    }
}

@end
