//
//  BMShareView.m
//  BaiduMall
//
//  Created by JK.PENG on 15/10/29.
//  Copyright © 2015年 baidu. All rights reserved.
//

#import "BMShareView.h"
#import "Masonry.h"
#import "UIView+BMFrame.h"
#import "BMSocialShareManager.h"

#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

@implementation BMShareItem
@end

@interface BMShareViewCell()

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UILabel      *nameLabel;

@end

@implementation BMShareViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self imageView];
        [self nameLabel];
    }
    return self;
}

#pragma mark - getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@(0));
            make.width.and.height.equalTo(@60);
        }];
    }
    return _imageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self).with.offset(0);
            make.height.equalTo(@(20));
            make.top.equalTo(self.imageView.mas_bottom).with.offset(1);
        }];
    }
    return _nameLabel;
}

@end

NSString * const kBMShareViewCellWithReuseIdentifier  = @"kBMShareViewCellWithReuseIdentifier";

@interface BMShareView() <UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIView   *containerView;
@property (nonatomic, strong) UICollectionView    *collectionView;
@property (nonatomic, strong) NSArray             *dataArray;
@property (nonatomic, strong) BMSocialShareContent   *shareContent;
@property (nonatomic, strong) BMSocialShareBlock     shareBlock;

@end

@implementation BMShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5f];
        UIButton  *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tapButton.frame = self.bounds;
        [tapButton addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tapButton];
        [self containerView];
        [self collectionView];
    }
    return self;
}

+ (void)presentShareViewWithShareContent:(BMSocialShareContent *)content
                              completion:(BMSocialShareBlock)block{
    BMShareView  *shareView = [[BMShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    shareView.shareContent = content;
    shareView.shareBlock = block;
    [shareView showShareView];
}

- (void)showShareView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.containerView.bm_bottom = self.bm_height;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)hideShareView{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.containerView.bm_bottom = self.bm_height+self.containerView.bm_height;
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMShareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBMShareViewCellWithReuseIdentifier forIndexPath:indexPath];
    BMShareItem  *item = self.dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:item.icon];
    cell.nameLabel.text = item.name;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BMShareItem  *item = self.dataArray[indexPath.row];
    self.shareContent.socialPlatform = item.type;
    __weak __typeof(self) weakSelf = self;
    [[BMSocialShareManager shared] shareToSocialPlatformWithShareContent:self.shareContent compBlock:^(NSString *message, BOOL success) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.shareBlock(self.shareContent.socialPlatform, message);
    }];
    [self hideShareView];
}

#pragma mark - getter
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSMutableArray *shareArray = [NSMutableArray array];
        BMShareItem  *item1 = [[BMShareItem alloc] init];
        item1.icon = @"share_wx_session";
        item1.name = @"微信好友";
        item1.type = kSocialPlatformTypeWXSession;
        [shareArray addObject:item1];
        
        BMShareItem  *item2 = [[BMShareItem alloc] init];
        item2.icon = @"share_wx_timeline";
        item2.name = @"微信朋友圈";
        item2.type = kSocialPlatformTypeWXTimeline;
        [shareArray addObject:item2];
        
        BMShareItem  *item3 = [[BMShareItem alloc] init];
        item3.icon = @"share_qq";
        item3.name = @"QQ好友";
        item3.type = kSocialPlatformTypeQQ;
        [shareArray addObject:item3];
        
        BMShareItem  *item4 = [[BMShareItem alloc] init];
        item4.icon = @"share_qqzone";
        item4.name = @"QQ空间";
        item4.type = kSocialPlatformTypeQZone;
        [shareArray addObject:item4];
        
        BMShareItem  *item5 = [[BMShareItem alloc] init];
        item5.icon = @"share_weibo";
        item5.name = @"新浪微博";
        item5.type = kSocialPlatformTypeSinaWB;
        [shareArray addObject:item5];
        _dataArray = [NSArray arrayWithArray:shareArray];
    }
    return _dataArray;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220)];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_containerView];
        UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"分享";
        [_containerView addSubview:titleLabel];
    }
    return _containerView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200) collectionViewLayout:layout];
        _collectionView.pagingEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[BMShareViewCell class] forCellWithReuseIdentifier:kBMShareViewCellWithReuseIdentifier];
        [self.containerView addSubview:self.collectionView];
    }
    return _collectionView;
}

@end
