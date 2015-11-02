//
//  BMSocialShareContent.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKSocialDef.h"

@interface BMSocialShareContent : NSObject

@property (nonatomic, strong, readonly) UIImage    *thumbImage;
@property (nonatomic, strong, readonly) NSString   *shareTitle;
@property (nonatomic, strong, readonly) NSString   *shareDesc;
@property (nonatomic, strong, readonly) NSString   *shareContent;
@property (nonatomic, strong, readonly) NSString   *shareURL;
@property (nonatomic, assign, readonly) SocialShareContentTypeE   contentType;
@property (nonatomic, assign) SocialPlatformTypeE       socialPlatform;
@property (nonatomic, assign, readonly) BOOL       needImgCompressed;

+ (BMSocialShareContent *)shareContentWithImage:(UIImage *)image
                                          title:(NSString *)title
                                           desc:(NSString *)description
                                        content:(NSString *)content
                                         webUrl:(NSString *)webUrl
                                           type:(SocialShareContentTypeE)type
                                       platform:(SocialPlatformTypeE)platformType
                                     compressed:(BOOL)compressed;
@end
