//
//  BMSocialDefine.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#ifndef BMSocialDefine_h
#define BMSocialDefine_h

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

///**
// 微信内容类型
// */
//typedef enum{
//    UMSocialWXMessageTypeNone,
//    UMSocialWXMessageTypeText,      //微信消息文本类型
//    UMSocialWXMessageTypeImage,     //微信消息图片类型
//    UMSocialWXMessageTypeApp,       //微信消息应用类型
//    UMSocialWXMessageTypeWeb,       //微信消息网页类型
//    UMSocialWXMessageTypeMusic,     //微信消息音乐类型
//    UMSocialWXMessageTypeVideo,     //微信消息视频类型
//    UMSocialWXMessageTypeEmotion,   //微信消息表情类型
//    UMSocialWXMessageTypeOther      //微信消息其他多媒体类型
//}UMSocialWXMessageType;


#endif /* BMSocialDefine_h */
