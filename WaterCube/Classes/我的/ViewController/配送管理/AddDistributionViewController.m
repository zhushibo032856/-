//
//  AddDistributionViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "AddDistributionViewController.h"

@interface AddDistributionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *NameTF;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;

@end

@implementation AddDistributionViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"添加配送员";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _SubmitBT.layer.masksToBounds = YES;
    _SubmitBT.layer.cornerRadius = 8;
    // Do any additional setup after loading the view from its nib.
}




- (IBAction)SubmitBtAction:(UIButton *)sender {
    if (kStringIsEmpty(self.NameTF.text)) {
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    if (![RandomClass checkTelNumber:self.PhoneTF.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    if (kStringIsEmpty(self.PhoneTF.text)) {
        [MBProgressHUD showError:@"手机号不能为空"];
        return;
    }
    if (kStringIsEmpty(self.PasswordTF.text)) {
        [MBProgressHUD showError:@"登录密码不能为空"];
        return;
    }
    
    [self uploadDataWith:self.NameTF.text Phone:self.PhoneTF.text PassWord:self.PasswordTF.text];
    
}

- (void)uploadDataWith:(NSString *)name
                 Phone:(NSString *)phone
              PassWord:(NSString *)passWord{
    
    NSDictionary *partner = @{
                              @"mchNo": KSHOPMCHNUMBER,
                              @"name": name,
                              @"phone": phone
                              };
    NSString *url = [NSString stringWithFormat:@"%@/api/a/hamal/insertHamal",KFORMALURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:partner progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"添加成功"];
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
