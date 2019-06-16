//
//  OrderViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "OrderViewController.h"
#import "XXPageTabView.h"
#import "AllOrderViewController.h"
#import "ReceiptViewController.h"
#import "DeliveryViewController.h"
#import "FinishViewController.h"



@interface OrderViewController ()<XXPageTabViewDelegate>
{
    XXPageTabView *_pageTabView;
    
}
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSegmentVC];
    // Do any additional setup after loading the view.
}

- (void)setSegmentVC{
    
    AllOrderViewController *newOrderVC = [[AllOrderViewController alloc]init];
    
    ReceiptViewController *cuiDanVC = [[ReceiptViewController alloc]init];
    
    DeliveryViewController *cancelVC = [[DeliveryViewController alloc]init];
    
    FinishViewController *refundVC = [[FinishViewController alloc]init];
    
    [self addChildViewController:newOrderVC];
    [self addChildViewController:cuiDanVC];
    [self addChildViewController:cancelVC];
    [self addChildViewController:refundVC];
    
    _pageTabView = [[XXPageTabView alloc]initWithChildControllers:self.childViewControllers childTitles:@[@"全部",@"待接单",@"待配送",@"已完成"]];
    _pageTabView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavHeight);
    _pageTabView.tabSize = CGSizeMake(kScreenWidth, 44);
    _pageTabView.tabItemFont = [UIFont systemFontOfSize:17];
    _pageTabView.unSelectedColor = kColor(0, 0, 0);
    _pageTabView.selectedColor = kColor(0, 122, 255);
    
    _pageTabView.bodyBounces = NO;
    _pageTabView.titleStyle = XXPageTabTitleStyleGradient;
    _pageTabView.indicatorStyle = XXPageTabIndicatorStyleFollowText;
    _pageTabView.delegate = self;
    [self.view addSubview:_pageTabView];
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
