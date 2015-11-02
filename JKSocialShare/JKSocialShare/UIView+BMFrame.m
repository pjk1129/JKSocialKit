//
//  UIView+BMFrame.m
//  BaiduMall
//
//  Created by baidu on 15/6/3.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "UIView+BMFrame.h"

@implementation UIView (BMFrame)

- (CGFloat)bm_left {
    return self.frame.origin.x;
}

- (void)setBm_left:(CGFloat)bm_left {
    CGRect frame = self.frame;
    frame.origin.x = bm_left;
    self.frame = frame;
}

- (CGFloat)bm_top {
    return self.frame.origin.y;
}

- (void)setBm_top:(CGFloat)bm_top {
    CGRect frame = self.frame;
    frame.origin.y = bm_top;
    self.frame = frame;
}

- (CGFloat)bm_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBm_right:(CGFloat)bm_right {
    CGRect frame = self.frame;
    frame.origin.x = bm_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bm_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBm_bottom:(CGFloat)bm_bottom {
    CGRect frame = self.frame;
    frame.origin.y = bm_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bm_centerX {
    return self.center.x;
}

- (void)setBm_centerX:(CGFloat)bm_centerX {
    self.center = CGPointMake(bm_centerX, self.center.y);
}

- (CGFloat)bm_centerY {
    return self.center.y;
}

- (void)setBm_centerY:(CGFloat)bm_centerY {
    self.center = CGPointMake(self.center.x, bm_centerY);
}

- (CGFloat)bm_width {
    return self.frame.size.width;
}

- (void)setBm_width:(CGFloat)bm_width {
    CGRect frame = self.frame;
    frame.size.width = bm_width;
    self.frame = frame;
}

- (CGFloat)bm_height {
    return self.frame.size.height;
}

- (void)setBm_height:(CGFloat)bm_height {
    CGRect frame = self.frame;
    frame.size.height = bm_height;
    self.frame = frame;
}

- (CGPoint)bm_origin {
    return self.frame.origin;
}

- (void)setBm_origin:(CGPoint)bm_origin {
    CGRect frame = self.frame;
    frame.origin = bm_origin;
    self.frame = frame;
}

- (CGSize)bm_size {
    return self.frame.size;
}

- (void)setBm_size:(CGSize)bm_size {
    CGRect frame = self.frame;
    frame.size = bm_size;
    self.frame = frame;
}

@end
