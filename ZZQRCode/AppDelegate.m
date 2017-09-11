//
//  AppDelegate.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/8/7.
//  Copyright © 2017年 ZP. All rights reserved.
// build new

#import "AppDelegate.h"
#import "ZZQRCodeTableviewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //给nav设置一个控制器
    ZZQRCodeTableviewController *ZZQRCodeTVC = [[ZZQRCodeTableviewController alloc] init];
    ZZQRCodeTVC.view.backgroundColor = [UIColor whiteColor];
    
    //创建一个导航栏控制器.并把one设置为nav的根控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ZZQRCodeTVC];
    
    //把控制器设置为window的根控制器
    self.window.rootViewController = nav;
    
    //将窗口设置为window的主窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
