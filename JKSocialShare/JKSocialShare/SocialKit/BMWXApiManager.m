//
//  BMWXApiManager.m
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "BMWXApiManager.h"
#import "JKSocialDef.h"

@interface BMWXApiManager()<WXApiDelegate>

@property (nonatomic, weak) id<BMWXApiManagerDelegate>  apiDelegate;
@end

@implementation BMWXApiManager

- (instancetype)initWithDelegate:(id<BMWXApiManagerDelegate>)delegate{
    self = [super init];
    if (self) {
        self.apiDelegate = delegate;
    }
    return self;
}

-(BOOL)handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)registerWeChatApp:(NSString *)appid{
    [WXApi registerApp:appid];
}

- (void)shareToWXWithShareContent:(BMSocialShareContent *)content{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    
    if (content.contentType == kSocialShareContentTypeText) {
        req.bText = YES;
        req.text = content.shareContent;
    }else{
        req.bText = NO;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [content.shareTitle length]<=0?@"百度Mall":content.shareTitle;
        message.description = content.shareDesc;
        [message setThumbImage:JKGetThumbImgae(content.thumbImage, 32)];
        
        if (content.contentType == kSocialShareContentTypeMedia) {
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = content.shareURL;
            message.mediaObject = ext;
        }else if (content.contentType == kSocialShareContentTypeImage){
            WXImageObject  *imgObj = [WXImageObject object];
            imgObj.imageData = UIImagePNGRepresentation(content.thumbImage);
            message.mediaObject = imgObj;
        }
        req.message = message;
    }
    //选择发送到朋友圈，默认值为WXSceneSession，发送到会话
    if (content.socialPlatform == kSocialPlatformTypeWXTimeline) {
        req.scene = WXSceneTimeline;
    }else{
        req.scene = WXSceneSession;
    }
    [WXApi sendReq:req];
}

#pragma mark - WXApiDelegate
-(void)onReq:(BaseReq*)req
{
    
}

-(void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        if ([_apiDelegate respondsToSelector:@selector(wxShareResponseDidSuccess:)]) {
            [_apiDelegate wxShareResponseDidSuccess:(resp.errCode == WXSuccess)];
        }
    }
}


@end
