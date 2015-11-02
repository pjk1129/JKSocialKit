//
//  JKSocialDef.m
//  JKSocialShare
//
//  Created by JK.PENG on 15/11/2.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "JKSocialDef.h"

UIImage * JKGetThumbImgae(UIImage  *image, NSInteger maxSize){
    CGFloat  size  = (image.size.width*image.size.height)/1024;
    CGFloat  scaleSize = (size<maxSize)?1.0:(maxSize/size);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize), YES, 0);
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;
}

@implementation JKSocialDef

@end
