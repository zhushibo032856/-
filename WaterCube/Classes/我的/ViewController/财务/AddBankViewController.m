//
//  AddBankViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "AddBankViewController.h"

@interface AddBankViewController ()

@property (weak, nonatomic) IBOutlet UITextField *NameTF;
@property (weak, nonatomic) IBOutlet UITextField *PhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *BankTF;
@property (weak, nonatomic) IBOutlet UITextField *ChildBankTF;
@property (weak, nonatomic) IBOutlet UITextField *BankNumTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;


@end

@implementation AddBankViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"绑定银行卡";
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
    
    if (kStringIsEmpty(_NameTF.text)) {
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    if (kStringIsEmpty(_PhoneTF.text)) {
        [MBProgressHUD showError:@"手机号不能为空"];
        return;
    }
    if (kStringIsEmpty(_BankTF.text)) {
        [MBProgressHUD showError:@"银行不能为空"];
        return;
    }
    if (kStringIsEmpty(_ChildBankTF.text)) {
        [MBProgressHUD showError:@"支行不能为空"];
        return;
    }
    if (kStringIsEmpty(_BankNumTF.text)) {
        [MBProgressHUD showError:@"银行卡号不能为空"];
        return;
    }
    [self uploadDataWith:_NameTF.text Phone:_PhoneTF.text Bnak:_BankTF.text ChildBank:_ChildBankTF.text BankNumber:_BankNumTF.text];
}

- (void)uploadDataWith:(NSString *)name
                 Phone:(NSString *)phone
                  Bnak:(NSString *)bank
             ChildBank:(NSString *)childBank
            BankNumber:(NSString *)bankNumber{
    
    NSDictionary *partner = @{
                              @"bankBranchName": childBank,
                              @"bankName": bank,
                              @"bankNum": bankNumber,
                              @"mchNo": KSHOPMCHNUMBER,
                              @"trueName": name
                              };
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/merchantBank/insertMerchantBank",KFORMALURL];
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
