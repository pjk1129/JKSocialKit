//
//  ViewController.m
//  JKSocialShare
//
//  Created by JK.PENG on 15/11/2.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "ViewController.h"
#import "BMShareView.h"
#import "BMPromptView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)share:(id)sender {
    BMSocialShareContent  *content = [BMSocialShareContent shareContentWithImage:[UIImage imageNamed:@"mall_logo"] title:@"百度Mall" desc:@"百度Mall，为您甄选" content:@"新电商平台，全部真货" webUrl:@"http://mall.baidu.com" type:kSocialShareContentTypeMedia platform:kSocialPlatformTypeQQ compressed:NO];
    
    __weak __typeof(self) weakSelf = self;
    [BMShareView presentShareViewWithShareContent:content completion:^(SocialPlatformTypeE plateType, NSString *message) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (message) {
            [BMPromptView showPromptInView:strongSelf.view message:message];
        }
    }];
}

@end
