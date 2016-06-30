//
//  ViewController.m
//  TLoadingView
//
//  Created by weiping.tan on 16/6/30.
//  Copyright © 2016年 SSaaS. All rights reserved.
//

#import "ViewController.h"
#import "TLoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 200, 80, 40)];
    
    [addButton setTitle:@"加载" forState:UIControlStateNormal];
    
    addButton.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchDown];
    
  
    
//    ;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dissMissView
{
    [[TLoadingView sharedInstance] dissMiss];
}

-(void)show
{
    
      [self performSelector:@selector(dissMissView) withObject:nil afterDelay:8];
    
        [[TLoadingView sharedInstance] showLodingViewWithTitle:@"加载中..." view:self.view dissmiss:^(DissmissStatus status) {
        
        if (status==DissmissStatusUserMake)
        {
            NSLog(@"%@",@"主动隐藏");
        }else
        {
            NSLog(@"%@",@"自动隐藏");
        }
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
