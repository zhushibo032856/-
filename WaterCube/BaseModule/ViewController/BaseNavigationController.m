//
//  BaseNavigationController.m
//  HXEDigitalRestaurant
//
//  Created by apple on 2019/1/26.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_navigation_background"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar_navigation_clear"]];
    

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
