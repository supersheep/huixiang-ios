//
//  AppDelegate.m
//  Huixiang
//
//  Created by ltebean on 13-6-13.
//  Copyright (c) 2013年 ltebean. All rights reserved.
//

#import "AppDelegate.h"
#import "HuixiangIAPHelper.h"
#import "SVProgressHUD.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 设置背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:60/255.0f green:58/255.0f blue:55/255.0f alpha:1.0f ]];
    
    
    UIImage* img = [UIImage imageNamed:@"navbar"];
    [[UINavigationBar appearance] setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
  
    // 字体前景色以及大小
    UIColor* color = [UIColor colorWithRed:255.0/255.0 green:245.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIFont* font = [UIFont boldSystemFontOfSize:24];
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           color, NSForegroundColorAttributeName,
                           font, NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes: attrs];
    
    // 设置文字纵向偏移
    CGFloat verticalOffset = 2;
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
    
    // 状态栏浅色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // tab栏背景色
    UIImage* tabBarBackground = [UIImage imageNamed:@"tab.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    // 选中时的背景
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"empty.png"]];

    [HuixiangIAPHelper sharedInstance];
    [WXApi registerApp:@"wxf7421652d9938d6b"];
    return YES;
}


// 从外部跳转回来
-(BOOL)application:(UIApplication *) application handleOpenURL:(NSURL *)url
{
    // 来自微信
    return [WXApi handleOpenURL:url delegate:self];
}

// 跳转外部应用
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 跳转至微信
    return [WXApi handleOpenURL:url delegate:self];
}


-(void) onReq:(BaseReq*)req
{
    
}


-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *title;
        if(resp.errCode==WXSuccess){
            title = @"发送成功";
            [SVProgressHUD showSuccessWithStatus:title];
            return;
        }else if(resp.errCode==WXErrCodeAuthDeny){
            title =@"授权失败";
        }else if(resp.errCode==WXErrCodeSentFail){
            title =@"发送失败";
        }else if(resp.errCode==WXErrCodeUnsupport){
            title =@"该版本微信不支持此操作";
        }else if(resp.errCode==WXErrCodeUserCancel){
            title =@"分享被取消";
        }else{
            title =@"未知错误";
        }
        [SVProgressHUD showErrorWithStatus:title];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
