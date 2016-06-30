//
//  TLoadingView.h
//  TLoadingView
//
//  Created by weiping.tan on 16/6/30.
//  Copyright © 2016年 SSaaS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DissmissStatus) {
    DissmissStatusAutomatic = 0,//自动关闭
    DissmissStatusUserMake //主动关闭
};

@interface TLoadingView : UIView




//唯一单列
+ (instancetype) sharedInstance;

/**
 *  消失
 */
-(void)dissMiss;
/**
 *  展示加载视图
 *
 *  @param title
 *  @param view
 */
-(void)showLodingViewWithTitle:(NSString *)title view:(UIView *)view  dissmiss:(void (^) (DissmissStatus Status))_dissmiss;



@end
