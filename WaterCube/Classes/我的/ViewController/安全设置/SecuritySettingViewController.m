//
//  SecuritySettingViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "SecuritySettingViewController.h"
#import "ChangePhoneViewController.h"
#import "ChangePasswordViewController.h"

@interface SecuritySettingViewController ()

@end

@implementation SecuritySettingViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"安全设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ChangePhoneTapAction:(UITapGestureRecognizer *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    ChangePhoneViewController *phoneVC = [[ChangePhoneViewController alloc]init];
    [self.navigationController pushViewController:phoneVC animated:YES];
    
}
- (IBAction)ChangePasswordAction:(UITapGestureRecognizer *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    ChangePasswordViewController *passVC = [[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:passVC animated:YES];
    
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
