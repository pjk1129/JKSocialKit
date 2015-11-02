//
//  BMSocialShareContent.m
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "BMSocialShareContent.h"

@interface BMSocialShareContent()

@property (nonatomic, strong) UIImage    *thumbImage;
@property (nonatomic, strong) NSString   *shareTitle;
@property (nonatomic, strong) NSString   *shareDesc;
@property (nonatomic, strong) NSString   *shareContent;
@property (nonatomic, strong) NSString   *shareURL;
@property (nonatomic, assign) SocialShareContentTypeE   contentType;
@property (nonatomic, assign) BOOL       needImgCompressed;

@end

@implementation BMSocialShareContent

+ (BMSocialShareContent *)shareContentWithImage:(UIImage *)image
                                          title:(NSString *)title
                                           desc:(NSString *)description
                                        content:(NSString *)content
                                         webUrl:(NSString *)webUrl
                                           type:(SocialShareContentTypeE)type
                                       platform:(SocialPlatformTypeE)platformType
                                     compressed:(BOOL)compressed{
    BMSocialShareContent  *socialContent = [[BMSocialShareContent alloc] init];
    socialContent.thumbImage = image;
    socialContent.shareTitle = title;
    socialContent.shareDesc = description;
    socialContent.shareContent = content;
    socialContent.shareURL = webUrl;
    socialContent.contentType = type;
    socialContent.needImgCompressed = compressed;
    socialContent.socialPlatform = platformType;
    return socialContent;
}
@end
