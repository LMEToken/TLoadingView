//
//  TLoadingView.m
//  TLoadingView
//
//  Created by weiping.tan on 16/6/30.
//  Copyright © 2016年 SSaaS. All rights reserved.
//

#import "TLoadingView.h"


@interface TLoadingView ()

/**
 *  转圈菊花
 */
@property (nonatomic,strong)UIActivityIndicatorView *activityView;
/**
 *  标题名称
 */
@property (nonatomic,strong) UILabel *titleLable;
/**
 *  取消button
 */
@property (nonatomic,strong) UIButton *canleceButton;
/**
 *  背景图
 */
@property (nonatomic,strong) UIView *backView;
/**
 *  loading视图
 */
@property (nonatomic,strong) UIView *loadingView;

@property (nonatomic,strong) void (^dismissCallback) (DissmissStatus status);

@end
/**
 将色值转换成可用颜色
 */
#define TomColor(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static TLoadingView *sharedInstance;

@implementation TLoadingView

+ (instancetype) sharedInstance
{
    // 全局单例

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[TLoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
    });
    
    return sharedInstance;
}

-(void)initShowView:(UIView *)view title:(NSString *)title
{
    if (!self.backView)
    {
        self.backView = [[UIView alloc]initWithFrame:view.bounds];

        [self addSubview:self.backView];
    }

    
    self.backView.backgroundColor = [UIColor blackColor];
    
    self.backView.alpha = .7;
    
    
    if (!self.loadingView) {
      self.loadingView   = [[UIView alloc]initWithFrame:CGRectMake(view.frame.size.width/2 - 90, view.frame.size.height/2 - 30, 180, 59)];
      [self addSubview:self.loadingView];
        
    }
  
    self.loadingView.backgroundColor = [UIColor whiteColor];
    
    

    
    if (!self.activityView)
    {
        self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [self.activityView setFrame:CGRectMake(10, 10,40,40)];

        [self.loadingView addSubview:self.activityView];
    }
    [self.activityView startAnimating];

    
    if (!self.titleLable)
    {
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(45, 15,90, 30)];
        
        [self.loadingView addSubview:self.titleLable];
    }

    [self.titleLable setText:title];

    [self.titleLable setTextAlignment:NSTextAlignmentCenter];
    
    [self.titleLable setTextColor:TomColor(0x828282)];
    
    [self.titleLable setFont:[UIFont systemFontOfSize:16]];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(130, 11, 1, 38)];
    
    lineView.backgroundColor = [UIColor grayColor];
    
    [self.loadingView addSubview:lineView];
    
    
    if (!self.canleceButton)
    {
        self.canleceButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 15, 30, 30)];

        [self.loadingView addSubview:self.canleceButton];
    
    }
    
    [self.canleceButton addTarget:self action:@selector(userDissMissView) forControlEvents:UIControlEventTouchDown];

    [self.canleceButton setImage:[UIImage imageNamed:@"chacha"] forState:UIControlStateNormal];
    

}
/**
 *  用户主动消失
 */
-(void)userDissMissView
{
    [sharedInstance setHidden:YES];
    
    
    if (self.dismissCallback) {
        self.dismissCallback(DissmissStatusUserMake);
    }
    
}


/**
 *  消失
 */
-(void)dissMiss
{
    [sharedInstance setHidden:YES];

    if (self.dismissCallback) {
        self.dismissCallback(DissmissStatusAutomatic);
    }
}
/**
 *  展示加载视图
 *
 *  @param title
 *  @param view
 */
-(void)showLodingViewWithTitle:(NSString *)title view:(UIView *)view  dissmiss:(void (^) (DissmissStatus Status))_dissmiss
{
    self.dismissCallback = _dissmiss;
    
    [sharedInstance setHidden:NO];
    
    [sharedInstance initShowView:self title:title];
    
    [view addSubview:sharedInstance];
    
 
}

@end
