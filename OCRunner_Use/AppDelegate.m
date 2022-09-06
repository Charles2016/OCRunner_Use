//
//  AppDelegate.m
//  OCRunner_Use
//
//  Created by 1084-Wangcl-Mac on 2022/7/19.
//  Copyright © 2022 Charles2021. All rights reserved.
//

#import "AppDelegate.h"
#import "MainVC.h"
#import "AppDelegate+OCRunner.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadOCRunner];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[MainVC alloc]init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
