//
//  UIView+loading.m
//  LYSLoadingView
//
//  Created by jk on 2017/4/19.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "UIView+loading.h"

static NSInteger tag = 100000;

@implementation UIView (loading)

#pragma mark - 开始加载
-(void)beginLoading:(NSDictionary*)options{
    
    NSMutableDictionary * styleOptions = [NSMutableDictionary dictionaryWithDictionary:options];
    if (![styleOptions objectForKey:@"textColor"]) {
        [styleOptions setObject:[UIColor whiteColor] forKey:@"textColor"];
    }
    if (![styleOptions objectForKey:@"textHeight"]) {
        [styleOptions setObject:[NSNumber numberWithFloat:20.f] forKey:@"textHeight"];
    }
    if (![styleOptions objectForKey:@"textFont"]) {
        [styleOptions setObject:[UIFont systemFontOfSize:14] forKey:@"textFont"];
    }
    if (![styleOptions objectForKey:@"text"]) {
        [styleOptions setObject:@"正在加载..." forKey:@"text"];
    }
    if (![styleOptions objectForKey:@"padding"]) {
        [styleOptions setObject:[NSNumber numberWithFloat:10.f] forKey:@"padding"];
    }
    if (![styleOptions objectForKey:@"bgColor"]) {
        [styleOptions setObject:[UIColor clearColor] forKey:@"bgColor"];
    }
    if (![styleOptions objectForKey:@"loadingStyle"]) {
        [styleOptions setObject:[NSNumber numberWithInteger:UIActivityIndicatorViewStyleWhite] forKey:@"loadingStyle"];

    }
    UIView *loadingView = [[UIView alloc]initWithFrame:self.bounds];
    loadingView.backgroundColor = [styleOptions objectForKey:@"bgColor"];
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = [styleOptions objectForKey:@"text"];
    tipLabel.textColor = [styleOptions objectForKey:@"textColor"];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [styleOptions objectForKey:@"textFont"];
    CGFloat width = [self widthForFont:tipLabel.font str:tipLabel.text];
    CGFloat height = [[styleOptions objectForKey:@"textHeight"] floatValue];
    CGFloat padding = [[styleOptions objectForKey:@"padding"] floatValue];
    tipLabel.frame = CGRectMake((CGRectGetWidth(self.frame) - width) * 0.5 + height, (CGRectGetHeight(self.frame) - height) * 0.5, width, height);
    [loadingView addSubview:tipLabel];
    UIActivityIndicatorView *indcatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(CGRectGetMinX(tipLabel.frame) - padding - height, CGRectGetMinY(tipLabel.frame), height, height)];
    [indcatorView setActivityIndicatorViewStyle:[[styleOptions objectForKey:@"loadingStyle"] integerValue]];
    loadingView.tag = tag;
    [loadingView addSubview:indcatorView];
    [self addSubview:loadingView];
    [indcatorView startAnimating];
    [self bringSubviewToFront:loadingView];
}

- (CGSize)sizeForFont:(UIFont *)font str:(NSString*)str size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [str boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [str sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font str:(NSString*)str{
    CGSize size = [self sizeForFont:font str:str size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width str:(NSString*)str{
    CGSize size = [self sizeForFont:font str:str size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

#pragma mark - 停止加载
-(void)endLoading{
    [[self viewWithTag:tag] removeFromSuperview];
}

@end
