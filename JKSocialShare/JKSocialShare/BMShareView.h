//
//  BMShareView.h
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSocialShareContent.h"

typedef void (^BMSocialShareBlock)(SocialPlatformTypeE plateType, NSString *message);

@interface BMShareItem : NSObject

@property (nonatomic, strong) NSString    *icon;
@property (nonatomic, strong) NSString    *name;
@property (nonatomic, assign) SocialPlatformTypeE   type;
@end

@interface BMShareViewCell : UICollectionViewCell

@end

@interface BMShareView : UIView

+ (void)presentShareViewWithShareContent:(BMSocialShareContent *)content
                              completion:(BMSocialShareBlock)block;
- (void)hideShareView;

@end
