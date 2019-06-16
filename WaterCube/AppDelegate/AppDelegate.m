//
//  AppDelegate.m
//  WaterCube
//
//  Created by apple on 2019/5/17.
//  Copyright © 2019年 aladdin. All rights reserved.
//  
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if(kStringIsEmpty(KUSERTOKEN)) {
        
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
        [self.window makeKeyAndVisible];
    }else{
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        BaseTabBarController *baseVC = [[BaseTabBarController alloc]init];
        self.window.rootViewController = baseVC;
        [self.window makeKeyAndVisible];
    }
    
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES; // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor =YES; // 控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour =IQAutoToolbarByTag; // 最新版
    
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                 stringByReplacingOccurrencesOfString:@">" withString:@""]
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",deviceTokenStr);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:deviceTokenStr forKey:@"deviceToken"];
    [user synchronize];
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
      NSLog(@"%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary * _Nonnull)userInfo fetchCompletionHandler:(void (^ _Nonnull)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"%@",userInfo);
    
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
