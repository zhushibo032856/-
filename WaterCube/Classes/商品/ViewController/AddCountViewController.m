//
//  AddCountViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "AddCountViewController.h"

@interface AddCountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *CountLable;
@property (weak, nonatomic) IBOutlet UITextField *MaxCountLable;
@property (weak, nonatomic) IBOutlet UIButton *SddBT;

@end

@implementation AddCountViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"添加库存";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.SddBT.layer.masksToBounds = YES;
    self.SddBT.layer.cornerRadius = 8;
    
    self.CountLable.text = [NSString stringWithFormat:@"%@",self.model.standard];
    self.MaxCountLable.text = [NSString stringWithFormat:@"%@",self.model.sellNum];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)AddBtAction:(UIButton *)sender {
    
    if (kStringIsEmpty(_CountLable.text)) {
        [MBProgressHUD showError:@"库存不能为空"];
        return;
    }
    if (kStringIsEmpty(_MaxCountLable.text)) {
        [MBProgressHUD showError:@"库存上限不能为空"];
        return;
    }
    if ([_MaxCountLable.text integerValue] < [_CountLable.text integerValue]) {
        [MBProgressHUD showError:@"库存不能大于库存上限"];
        return;
    }
    
}

- (void)uploadData{
    
    
    
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
