//
//  BMQQShareManager.m
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "BMQQShareManager.h"
#import "JKSocialDef.h"

@interface BMQQShareManager()

@property (nonatomic, weak) id<BMQQShareManagerDelegate>  qqDelegate;
@property (nonatomic, strong) TencentOAuth       *tencentOAuth;

@end

@implementation BMQQShareManager

- (instancetype)initWithDelegate:(id<BMQQShareManagerDelegate>)delegate{
    self = [super init];
    if (self) {
        self.qqDelegate = delegate;
    }
    return self;
}

-(BOOL)handleOpenURL:(NSURL *)url
{
    //tencent1104573782://response_from_qq?source=qq&source_scheme=mqqapi&error=0&version=1
    
    //tencent1104573782://response_from_qq?error_description=dGhlIHVzZXIgZ2l2ZSB1cCB0aGUgY3VycmVudCBvcGVyYXRpb24=&source=qq&source_scheme=mqqapi&error=-4&version=1
    if ([_qqDelegate respondsToSelector:@selector(qqShareResponseDidSuccess:)]) {
        NSRange  range = [url.absoluteString rangeOfString:@"error=0"];
        [_qqDelegate qqShareResponseDidSuccess:(range.location != NSNotFound)];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

- (void)registerQQApp:(NSString *)appid
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:nil];
}

- (void)shareToQQPlatformWithShareContent:(BMSocialShareContent *)content
{
    SendMessageToQQReq* req;
    if (content.contentType == kSocialShareContentTypeText) {
        QQApiTextObject *txtObj = [QQApiTextObject objectWithText:content.shareContent];
        req = [SendMessageToQQReq reqWithContent:txtObj];
    }else{
        CGFloat scale = 1.0;
        if (content.needImgCompressed){
            scale = 0.6;
        }
        NSData  *data = UIImageJPEGRepresentation(content.thumbImage,scale);
        if (content.contentType == kSocialShareContentTypeImage) {
            QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:content.shareTitle description:content.shareContent];
            req = [SendMessageToQQReq reqWithContent:img];
        }else{
            NSURL  *newsUrl = [NSURL URLWithString:[content.shareURL length]<=0?@"":content.shareURL];
            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:newsUrl title:content.shareTitle description:content.shareDesc previewImageData:data];
            req = [SendMessageToQQReq reqWithContent:newsObj];
        }
    }
    
    if (content.socialPlatform == kSocialPlatformTypeQQ) {
        [QQApiInterface sendReq:req];
    }else if (content.socialPlatform == kSocialPlatformTypeQZone){
        [QQApiInterface SendReqToQZone:req];
    }
}

@end
