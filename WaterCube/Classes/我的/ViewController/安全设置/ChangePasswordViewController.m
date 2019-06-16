//
//  ChangePasswordViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *OldPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *NewWordTF;
@property (weak, nonatomic) IBOutlet UITextField *InsureNewWordTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;

@end

@implementation ChangePasswordViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"修改密码";
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
    if (![_OldPassWordTF.text isEqualToString:KUSERPASSWORD]) {
        [MBProgressHUD showError:@"当前密码错误"];
        return;
    }
    if (kStringIsEmpty(_OldPassWordTF.text)) {
        [MBProgressHUD showError:@"当前密码不能为空"];
        return;
    }
    if (kStringIsEmpty(_NewWordTF.text)) {
        [MBProgressHUD showError:@"新密码不能为空"];
        return;
    }
    if (kStringIsEmpty(_InsureNewWordTF.text)) {
        [MBProgressHUD showError:@"新密码不能为空"];
        return;
    }
    if (![_NewWordTF.text isEqualToString:_InsureNewWordTF.text]) {
        [MBProgressHUD showError:@"新密码输入不一致"];
        return;
    }
    if (_NewWordTF.text.length < 6) {
        [MBProgressHUD showError:@"新密码长度不能小于6个字符"];
        return;
    }
    
    [self submitData];
}

- (void)submitData{
    
    NSDictionary *partner = @{
                              @"newPwd": _NewWordTF.text,
                              @"phone": KUSERPHONE,
                              @"pwd": _OldPassWordTF.text
                              };
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantSso/updatePassword",KFORMALURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:partner progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [kUserDefaults removeObjectForKey:@"token"];
            [kUserDefaults removeObjectForKey:@"password"];
            [kUserDefaults synchronize];
            
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            BaseNavigationController *loginNav = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:nil];
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
