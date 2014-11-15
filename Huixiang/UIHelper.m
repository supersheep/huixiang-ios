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
@end