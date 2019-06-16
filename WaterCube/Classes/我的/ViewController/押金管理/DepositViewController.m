//
//  DepositViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "DepositViewController.h"

@interface DepositViewController ()

@property (weak, nonatomic) IBOutlet UITextField *DepositTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;

@end

@implementation DepositViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"押金设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.SubmitBT.layer.masksToBounds = YES;
    self.SubmitBT.layer.cornerRadius = 8;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)SubmitBtAction:(UIButton *)sender {
    
    if (kStringIsEmpty(self.DepositTF.text)) {
        [MBProgressHUD showError:@"请输入押金金额"];
        return;
    }
    NSDictionary *partner = @{
                              @"mchNo": KSHOPMCHNUMBER,
                              @"tubDeposit": self.DepositTF.text
                              };
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantShop/updateTubDeposit",KFORMALURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:partner progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"设置成功"];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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
