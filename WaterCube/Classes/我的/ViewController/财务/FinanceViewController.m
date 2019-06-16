//
//  FinanceViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "FinanceViewController.h"
#import "FinanceDetailViewController.h"

@interface FinanceViewController ()

@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *TodyIncomeLable;
@property (weak, nonatomic) IBOutlet UILabel *MonthIncomeLable;

@end

@implementation FinanceViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"财务";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self requestDataFromNet];
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestDataFromNet{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/order/bizData?mchNo=%@",KFORMALURL,KSHOPMCHNUMBER];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            NSDictionary *data = responseObject[@"data"];
            CGFloat day = [[NSString stringWithFormat:@"%@",data[@"curDay"]] floatValue];
            CGFloat month = [[NSString stringWithFormat:@"%@",data[@"curMonth"]] floatValue];
            self.TodyIncomeLable.text = [NSString stringWithFormat:@"%.2f",day];
            self.MonthIncomeLable.text = [NSString stringWithFormat:@"%.2f",month];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)initView{
    
    self.BackView.layer.masksToBounds = YES;
    self.BackView.layer.cornerRadius = 8;
    
}

- (IBAction)FinanceTapAction:(UITapGestureRecognizer *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    FinanceDetailViewController *finVC = [[FinanceDetailViewController alloc]init];
    [self.navigationController pushViewController:finVC animated:YES];
    
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
