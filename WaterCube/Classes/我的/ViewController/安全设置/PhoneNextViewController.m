//
//  PhoneNextViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "PhoneNextViewController.h"

@interface PhoneNextViewController ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneTF;
@property (weak, nonatomic) IBOutlet UIButton *CodeBT;
@property (weak, nonatomic) IBOutlet UITextField *CodeTF;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBT;

@end

@implementation PhoneNextViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"修改手机号";
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
- (IBAction)CodeBtAction:(UIButton *)sender {

    if (![RandomClass checkTelNumber:self.PhoneTF.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@/api/b/sms/sendVerificationCode?phone=%@",KFORMALURL,_PhoneTF.text];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"获取验证码成功"];
            [self timeReduce];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
            self.CodeTF.text = @"";
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)timeReduce {
    
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.CodeBT setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.CodeBT setTitleColor:kColor(0, 122, 255) forState:UIControlStateNormal];
                [self.CodeBT setBackgroundColor:kColor(255, 255, 255)];
                self.CodeBT.userInteractionEnabled = YES;
            });
        }
        else {
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.CodeBT setTitle:[NSString stringWithFormat:@"%ds后重发", seconds] forState:UIControlStateNormal];
                [self.CodeBT setTitleColor:kColor(153, 153, 153) forState:UIControlStateNormal];
                [self.CodeBT setBackgroundColor:kColor(204, 204, 204)];
                self.CodeBT.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (IBAction)SubmitBtAction:(UIButton *)sender {
    
    if (kStringIsEmpty(_PhoneTF.text)) {
        [MBProgressHUD showError:@"手机号不能为空"];
        return;
    }
    if (kStringIsEmpty(_CodeTF.text)) {
        [MBProgressHUD showError:@"验证码不能为空"];
        return;
    }
    
    [self requestData];
}

- (void)requestData{
    
    NSDictionary *partner = @{
                              @"code": _CodeTF.text,
                              @"oldPhone": KUSERPHONE,
                              @"phone": _PhoneTF.text
                              };
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantSso/updatePhone",KFORMALURL];
    
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
            [kUserDefaults removeObjectForKey:@"phone"];
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
