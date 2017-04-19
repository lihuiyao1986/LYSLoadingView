//
//  ViewController.m
//  LYSLoadingView
//
//  Created by jk on 2017/4/19.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "UIView+loading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(20, 120, CGRectGetWidth(self.view.frame) - 40, 44.f);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    UIView *demoView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(btn.frame) + 40.f, CGRectGetWidth(self.view.frame) - 60, 100)];
    demoView.backgroundColor = [UIColor redColor];
    demoView.tag = 100;
    [self.view addSubview:demoView];
}

-(void)btnClicked:(UIButton*)sender{
    UIView * view = [self.view viewWithTag:100];
    [view beginLoading:@{
                         @"textHeight":[NSNumber numberWithFloat:20],
                         @"padding":[NSNumber numberWithFloat:0],
                         @"text":@"申请中..."
                         }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view endLoading];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
