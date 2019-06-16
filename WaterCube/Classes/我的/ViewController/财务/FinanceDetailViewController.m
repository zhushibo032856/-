//
//  FinanceDetailViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "FinanceDetailViewController.h"
#import "AddBankViewController.h"
#import "EditBankViewController.h"
#import "BillViewController.h"

#import "NoneBankView.h"
#import "BankView.h"

@interface FinanceDetailViewController ()

@property (nonatomic, strong) NoneBankView *noneBankView;
@property (nonatomic, strong) BankView *bankView;

@end

@implementation FinanceDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"结算信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self requestDataFromNet];
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            
            if ([data isKindOfClass:[NSNull class]]) {
                [self initNoneBankView];
            }else{
                [self initBankViewWith:data[@"bankName"] BankNum:data[@"bankNum"]];
            }
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma 没有绑定银行卡
- (void)initNoneBankView{

    _noneBankView = [NoneBankView SetHeadView];
    _noneBankView.backgroundColor = kColor(245, 245, 245);
    _noneBankView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.75);
    [_noneBankView.AddBankTap addTarget:self action:@selector(pushToAddBankView)];
    [self.view addSubview:_noneBankView];
}

- (void)pushToAddBankView{
    
    self.hidesBottomBarWhenPushed = YES;
    AddBankViewController *addVC = [[AddBankViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}



#pragma 已经绑定银行卡
- (void)initBankViewWith:(NSString *)bankName
                 BankNum:(NSString *)bankNum
{
    
    _bankView = [BankView SetHeadView];
    _bankView.backgroundColor = kColor(245, 245, 245);
    _bankView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    _bankView.FirstView.layer.masksToBounds = YES;
    _bankView.FirstView.layer.cornerRadius = 8;
    
    _bankView.BankName.text = [NSString stringWithFormat:@"%@",bankName];
    _bankView.BankNumber.text = [NSString stringWithFormat:@"%@",bankNum];
    
    _bankView.SecondView.backgroundColor = kColor(245, 245, 245);
    [_bankView.EditBankTap addTarget:self action:@selector(editBank)];
    [_bankView.BillTap addTarget:self action:@selector(pushToBillView)];
    
    [self.view addSubview:_bankView];
}

- (void)editBank{
    
    self.hidesBottomBarWhenPushed = YES;
    EditBankViewController *billVC = [[EditBankViewController alloc]init];
    [self.navigationController pushViewController:billVC animated:YES];
    
}
- (void)pushToBillView{
    
    self.hidesBottomBarWhenPushed = YES;
    BillViewController *billVC = [[BillViewController alloc]init];
    [self.navigationController pushViewController:billVC animated:YES];
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
