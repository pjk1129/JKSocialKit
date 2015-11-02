//
//  JKSocialDef.h
//  JKSocialShare
//
//  Created by JK.PENG on 15/11/2.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WXSceneTypeE) {
    WXSceneTypeSession       = 0,        /**< 聊天界面    */
    WXSceneTypeTimeline      = 1,        /**< 朋友圈      */
    WXSceneTypeFavorite      = 2,        /**< 收藏       */
};

typedef NS_ENUM(NSUInteger, WXMediaMessageTypeE) {
    WXMediaMessageTypeImage     = 0,
    WXMediaMessageTypeusic      = 1,
    WXMediaMessageTypeVideo     = 2,
    WXMediaMessageTypeWebpage   = 3,
};

typedef NS_ENUM(NSUInteger, TecnentPlatformTypeE) {
    kTecnentPlatformTypeQQ      = 0,
    kTecnentPlatformTypeQZONE   = 1,
};

typedef NS_ENUM(NSUInteger, SocialPlatformTypeE) {
    kSocialPlatformTypeQQ            = 0,
    kSocialPlatformTypeQZone         = 1,
    kSocialPlatformTypeWXSession     = 2,
    kSocialPlatformTypeWXTimeline    = 3,
    kSocialPlatformTypeSinaWB        = 4,
};

typedef NS_ENUM(NSUInteger, SocialShareContentTypeE) {
    kSocialShareContentTypeText         = 0,
    kSocialShareContentTypeImage        = 1,
    kSocialShareContentTypeMedia        = 2,
};

FOUNDATION_EXPORT UIImage * JKGetThumbImgae(UIImage  *image, NSInteger maxSize);

@interface JKSocialDef : NSObject

@end
