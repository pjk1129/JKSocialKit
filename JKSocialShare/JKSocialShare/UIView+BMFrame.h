//
//  UIView+BMFrame.h
//  BaiduMall
//
//  Created by baidu on 15/6/3.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BMFrame)

@property (nonatomic, assign) CGFloat bm_left;
@property (nonatomic, assign) CGFloat bm_top;
@property (nonatomic, assign) CGFloat bm_right;
@property (nonatomic, assign) CGFloat bm_bottom;
@property (nonatomic, assign) CGFloat bm_width;
@property (nonatomic, assign) CGFloat bm_height;

@property (nonatomic, assign) CGFloat bm_centerX;
@property (nonatomic, assign) CGFloat bm_centerY;

@property (nonatomic, assign) CGPoint bm_origin;
@property (nonatomic, assign) CGSize  bm_size;

@end
