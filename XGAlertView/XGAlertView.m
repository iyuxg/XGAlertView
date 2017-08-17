//
//  XGAlertView.m
//  XGAlertView
//
//  Created by if you on 2017/8/17.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "XGAlertView.h"

#define Start_Height -64
#define Height 64
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Left_Offset 45
#define Font_Size 16.0f
#define Image_Center_X 25
#define Image_Center_Y 40
#define Image_Width 24
@implementation XGAlertView

#pragma mark -- 创建伪单例，XGAlertView的唯一性
+ (XGAlertView *)shareManager
{
    static XGAlertView *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[XGAlertView alloc]init];
    });
    return shareManager;
}

#pragma mark -- 左侧的图标
- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, Image_Width, Image_Width);
        _imageView.center = CGPointMake(Image_Center_X, Image_Center_Y);
        [self addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark -- 右侧的文字
- (UILabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.frame = CGRectMake(Left_Offset, 20, Screen_Width - Left_Offset, 40);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont boldSystemFontOfSize:Font_Size];
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

#pragma mark -- 初始化
- (instancetype)init
{
    self = [super init];
    if (self){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAlertView)];
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark -- 点击AlertView
- (void)tapAlertView{
    [self dismiss];
    [self releaseTimer];
}

#pragma mark -- 主入口
- (void)showAlertViewTypewWithType:(AlertViewType)type title:(NSString *)title dismissAlertAfterTime:(NSInteger)time
{
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor whiteColor];
            self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor grayColor];
        }
            break;
        case AlertViewTypeError:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor whiteColor];
            self.imageView.image = [UIImage imageNamed:@"error"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor grayColor];
        }
            break;
        case AlertViewTypeMessage:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor whiteColor];
            self.imageView.image = [UIImage imageNamed:@"warm"];
            self.tipsLabel.text = title;
            self.tipsLabel.textColor = [UIColor grayColor];
        }
            break;
        default:
            break;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self show];
    [self releaseTimer];
    self.dismisTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                        target:self
                                                      selector:@selector(dismisAlertWithTimer:)
                                                      userInfo:nil
                                                       repeats:NO];
    
}

#pragma mark -- 移除alertView并释放定时器
- (void)dismisAlertWithTimer:(NSTimer *)timer
{
    [self releaseTimer];
    [self dismiss];
}

#pragma mark -- 释放定时器对象
- (void)releaseTimer
{
    [self.dismisTimer invalidate];
    self.dismisTimer = nil;
}

#pragma mark -- 显示
- (void)show
{
    [UIView animateWithDuration:0.6f
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, 32);
                         [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
                     }
                     completion:^(BOOL finished) {
                     }];
    
}

#pragma mark -- 移除
- (void)dismiss
{
    [UIView animateWithDuration:0.6f
                          delay:0
         usingSpringWithDamping:1.0f
          initialSpringVelocity:10.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, -32);
                     }
                     completion:^(BOOL finished) {
                         //[self removeFromSuperview];
                     }];
    
}

@end
