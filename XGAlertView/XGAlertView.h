//
//  XGAlertView.h
//  XGAlertView
//
//  Created by if you on 2017/8/17.
//  Copyright © 2017年 if you. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGAlertView : UIView

/** AlertViewType 为Alert的类型，决定使用哪张图片. */
typedef NS_ENUM(NSInteger,AlertViewType){
    AlertViewTypeSuccess = 0, //!< 成功.
    AlertViewTypeError   ,    //!< 失败.
    AlertViewTypeMessage      //!< 警告.
};

@property (nonatomic,assign) AlertViewType alertViewType;                                
@property (nonatomic,strong) UIImageView   *imageView;         //!< AlertView图片.
@property (nonatomic,strong) UILabel       *tipsLabel;         //!< AlertView文字.
@property (nonatomic,strong) NSTimer       *dismisTimer;
+ (XGAlertView *)shareManager;
- (void)showAlertViewTypewWithType:(AlertViewType)type title:(NSString *)title dismissAlertAfterTime:(NSInteger)time;
- (void)show;
- (void)dismiss;

@end
