//
//  EditBankViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "EditBankViewController.h"

@interface EditBankViewController ()
@property (weak, nonatomic) IBOutlet UITextField *NameTF;
@property (weak, nonatomic) IBOutlet UITextField *BankTF;
@property (weak, nonatomic) IBOutlet UITextField *ChildBankTF;
@property (weak, nonatomic) IBOutlet UITextField *BankNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;

@end

@implementation EditBankViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setTitle:@"删除" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(deleGateBank) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.title = @"编辑银行卡";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataFromNet];
    self.SubmitBT.layer.masksToBounds = YES;
    self.SubmitBT.layer.cornerRadius = 8;
    // Do any additional setup after loading the view from its nib.
}
- (void)requestDataFromNet{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/merchantBank/getByMchNo?mchNo=%@",KFORMALURL,KSHOPMCHNUMBER];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            NSDictionary *data = responseObject[@"data"];
            
            self.NameTF.text = [NSString stringWithFormat:@"%@",data[@"trueName"]];
            self.BankTF.text = [NSString stringWithFormat:@"%@",data[@"bankName"]];
            self.ChildBankTF.text = [NSString stringWithFormat:@"%@",data[@"bankBranchName"]];
            self.BankNumberTF.text = [NSString stringWithFormat:@"%@",data[@"bankNum"]];
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (IBAction)SbumitBtAction:(UIButton *)sender {
    
    if (kStringIsEmpty(_NameTF.text)) {
        [MBProgressHUD showError:@"姓名不能为空"];
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
    if (kStringIsEmpty(_BankNumberTF.text)) {
        [MBProgressHUD showError:@"银行卡号不能为空"];
        return;
    }
    [self uploadDataWith:_NameTF.text Bnak:_BankTF.text ChildBank:_ChildBankTF.text BankNumber:_BankNumberTF.text];
}

- (void)uploadDataWith:(NSString *)name
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
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/merchantBank/updateByMchNo",KFORMALURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:url parameters:partner progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)deleGateBank{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/merchantBank/deleteByMchNo?mchNo=%@",KFORMALURL,KSHOPMCHNUMBER];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"删除成功"];
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
