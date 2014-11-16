//
//  UIHelper.m
//  Huixiang
//
//  Created by ltebean on 13-7-5.
//  Copyright (c) 2013年 ltebean. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper
+(CGSize)measureTextHeight:(NSString*)text UIFont:font constrainedToSize:(CGSize)constrainedToSize
{
    CGSize mTempSize = [text sizeWithFont:font constrainedToSize:constrainedToSize lineBreakMode:UILineBreakModeWordWrap];
    return mTempSize;
}


+(void)setUpTabBar:(UIViewController *)vc withImageName:(NSString *)name andTitle:(NSString *)title
{
        if(vc){
            vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
            [vc.tabBarItem setImage:[UIImage imageNamed:name]];
            [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f], UITextAttributeTextColor,
                                                   nil] forState:UIControlStateNormal];
        }
}

+(void)setupHeader{
    
    // 设置头部背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:60/255.0f green:58/255.0f blue:55/255.0f alpha:1.0f ]];
    // 字体前景色以及大小
    UIColor* color = [UIColor colorWithRed:255.0/255.0 green:245.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIFont* font = [UIFont boldSystemFontOfSize:24];
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           color, NSForegroundColorAttributeName,
                           font, NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes: attrs];
    
    
    // 导航栏背景
    UIImage* img = [UIImage imageNamed:@"navbar"];
    [[UINavigationBar appearance] setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 状态栏浅色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 设置文字纵向偏移
    CGFloat verticalOffset = 2;
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
}
@end