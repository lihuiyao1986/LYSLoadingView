//
//  UIView+loading.h
//  LYSLoadingView
//
//  Created by jk on 2017/4/19.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (loading)

#pragma mark - 开始加载
-(void)beginLoading:(NSDictionary*)options;

#pragma mark - 停止加载
-(void)endLoading;

@end
