//
//  BaseTabBarController.m
//  HXEDigitalRestaurant
//
//  Created by apple on 2019/1/26.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = kColor(245, 245, 245);
    
    [self setColor];
    [self addChildViewControllers];
    
    // Do any additional setup after loading the view.
}

- (void)setColor {
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    // delete Top Line
    UIImage * tabBarShadow = [UIImage imageNamed:@"tabbar_navigation_clear"];
    [[UITabBar appearance] setShadowImage:tabBarShadow];
    [[UITabBar appearance] setBackgroundImage:tabBarShadow];
}

- (void)addChildViewControllers {
    

    OrderViewController *orderVC = [[OrderViewController alloc]init];
    [self addChildViewController:orderVC image:@"tabbar_navigation_orderNormal" selectedImage:@"tabbar_navigation_orderSelected" title:@"订单"];

    ManagerViewController *managerVC = [[ManagerViewController alloc]init];
    [self addChildViewController:managerVC image:@"tabbar_navigation_managerNormal" selectedImage:@"tabbar_navigation_managerSelected" title:@"商品"];

    MineViewController *mineVC = [[MineViewController alloc]init];
    [self addChildViewController:mineVC image:@"tabbar_navigation_mineNoamal" selectedImage:@"tabbar_navigation_mineSelected" title:@"我的"];
}

/**
 * 添加子控制器
 * @param childController 子控制器
 * @param imageName tabBarItem正常状态图片
 * @param selectedImageName tabBarItem选中状态图片
 * @param title 标题
 */
- (void)addChildViewController:(UIViewController *)childController image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title {
    
    BaseNavigationController *navigationVC = [[BaseNavigationController alloc] initWithRootViewController:childController];
    [navigationVC.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}] ;
    
    childController.title = title;
    childController.view.backgroundColor = kColor(245, 245, 245);
    
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    // childController.tabBarItem.imageInsets = UIEdgeInsetsMake(1.7f, 0.f, 1.5f, 0.f);
    [childController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.5f, -4.3f)];
    
    // Normarl
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = kColor(0, 0, 0);
    [childController.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];
    
    // Selected
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = kColor(0, 122, 255);
    [childController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    [self addChildViewController:navigationVC];
}

//#pragma mark -
//#pragma mark --- UITabBarControllerDelegate ---
//
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
//    NSLog(@"%@",KUSERTOKEN);
//    if ([viewController.tabBarItem.title isEqualToString:@"待处理"] || [viewController.tabBarItem.title isEqualToString:@"订单查询"] || [viewController.tabBarItem.title isEqualToString:@"管理"] || [viewController.tabBarItem.title isEqualToString:@"设置"]) { // 
//        if(kStringIsEmpty(KUSERTOKEN)) { // 判断是否登录过，没登录执行下面代码进入登录页
//            LoginViewController *loginVC = [LoginViewController new];
//            BaseNavigationController *loginNavVC = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//            [self presentViewController:loginNavVC animated:YES completion:nil];
//            return NO;
//        }
//        else { // 当登录后直接进入
//            return YES;
//        }
//    }
//    
//    return YES;
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
