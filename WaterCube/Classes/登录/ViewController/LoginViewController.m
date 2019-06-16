//
//  LoginViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *passWordTF;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *signButton;
@property (nonatomic, strong) UIButton *forgetPassword;

@end

static CGFloat const lineHeight = 0.8f;

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatLoginView];
    // Do any additional setup after loading the view.
}


- (void)creatLoginView {
    
    //logo
    self.logoView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.35, kScreenWidth * 0.2, kScreenWidth * 0.3, kScreenWidth * 0.45)];
    self.logoView.image = [UIImage imageNamed:@"Login_logo"];
    [self.view addSubview:self.logoView];
    
    //手机号
    self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth * 0.13, kScreenWidth * 0.68, kScreenWidth * 0.74, kScreenHeight * 0.076)];
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.phoneTF];
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.13, CGRectGetMaxY(self.phoneTF.frame), kScreenWidth * 0.74, lineHeight)];
    lineLable.backgroundColor = kColor(230, 230, 230);
    [self.view addSubview:lineLable];
    
    //密码
    self.passWordTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth * 0.13, self.phoneTF.y + kScreenHeight * 0.076, kScreenWidth * 0.5, kScreenHeight * 0.076)];
    self.passWordTF.placeholder = @"请输入密码";
    self.passWordTF.secureTextEntry = YES;
    [self.view addSubview:self.passWordTF];
    
    
//    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.imageButton.frame = CGRectMake(kScreenWidth * 0.75, self.phoneTF.y + kScreenHeight * 0.076 / 3 + kScreenHeight * 0.076, CGRectGetHeight(self.passWordTF.frame) / 3, CGRectGetHeight(self.passWordTF.frame) / 3);
//    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"Login_passImage-1"] forState:UIControlStateNormal];
//    [self.imageButton setTag:1000];
//    [self.imageButton addTarget:self action:@selector(changeImageWithTag) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.imageButton];
    
    
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(kScreenWidth * 0.13, CGRectGetMaxY(self.passWordTF.frame), kScreenWidth * 0.74, lineHeight))];
    line.backgroundColor = kColor(230, 230, 230);
    [self.view addSubview:line];
    
    //登录
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame = CGRectMake(kScreenWidth * 0.13, line.y + kScreenWidth * 0.1, kScreenWidth * 0.74, 50);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTintColor:[UIColor whiteColor]];
    
    [self.loginButton setBackgroundColor:[UIColor blueColor]];
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.loginButton];
    
    //成为商户
    self.signButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.signButton.frame = CGRectMake(kScreenWidth * 0.13, self.loginButton.bottom + 20, 80, 30);
    [self.signButton setTitle:@"成为商户" forState:UIControlStateNormal];
    self.signButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.signButton setTitleColor:kColor(51, 51, 51) forState:UIControlStateNormal];
    [self.signButton addTarget:self action:@selector(pushToRegisterVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signButton];
    
    
    
    
    
    //忘记密码
    
    self.forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPassword.frame = CGRectMake(self.loginButton.right - 80, CGRectGetMaxY(self.loginButton.frame) + 20, 80, 30);
    self.forgetPassword.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.forgetPassword setTitleColor:kColor(51, 51, 51) forState:UIControlStateNormal];
    [self.forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPassword addTarget:self action:@selector(pushToForgetVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPassword];
    
    
    if (!kStringIsEmpty(KUSERPHONE)) {
        self.phoneTF.text = KUSERPHONE;
    }
    if (!kStringIsEmpty(KUSERPASSWORD)) {
        self.passWordTF.text = KUSERPASSWORD;
    }
}

- (void)login{
    
    
    /** 判断手机号和密码格式 */
    if (![RandomClass checkTelNumber:self.phoneTF.text]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    if (self.passWordTF.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    if (self.passWordTF.text.length < 6) {
        [MBProgressHUD showError:@"密码长度不能小于6个字符"];
        return;
    }
    [self handleUserLoginAction];
    
}

/** 处理用户登录事件 */
- (void)handleUserLoginAction{
    
    
    NSDictionary *parameter = @{
                                @"phone":self.phoneTF.text,
                                @"pwd":self.passWordTF.text
                                };
    
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantSso/login",KFORMALURL];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"登录中...";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            NSLog(@"%@",responseObject);
        
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            
            [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
            [hud hideAnimated:YES];

            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setValue:self.phoneTF.text forKey:@"phone"];
            [user setValue:self.passWordTF.text forKey:@"password"];
            [user setValue:responseObject[@"data"] forKey:@"token"];
            [user synchronize];
            
            [self performSelector:@selector(successLogin) withObject:nil afterDelay:0.1];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
            [hud hideAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
        [MBProgressHUD showError:@"登录失败，请稍后再试" toView:self.navigationController.view];
    }];
    
}

#pragma mark 登录成功之后的操作
- (void)successLogin{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantSso/getMerchantShopByToken?token=%@",KFORMALURL,KUSERTOKEN];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  NSLog(@"%@",responseObject);
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            NSDictionary *data = responseObject[@"data"];
            NSDictionary *shopInfo = data[@"shopInfo"];
            NSDictionary *sso = data[@"sso"];
            [kUserDefaults setValue:shopInfo[@"bizLicImg"] forKey:@"shopImage"];
            [kUserDefaults setValue:shopInfo[@"shopName"] forKey:@"shopName"];
            [kUserDefaults setValue:shopInfo[@"mchNo"] forKey:@"mchNumber"];
            [kUserDefaults setValue:shopInfo[@"shopNo"] forKey:@"shopNumber"];
            [kUserDefaults setValue:shopInfo[@"city"] forKey:@"city"];
            [kUserDefaults setValue:sso[@"type"] forKey:@"shopType"];
            [kUserDefaults setValue:sso[@"id"] forKey:@"ID"];
            [kUserDefaults synchronize];
            
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    BaseTabBarController *baseVC = [[BaseTabBarController alloc]init];
    [self.navigationController pushViewController:baseVC animated:YES];
    
}



#pragma mark 注册商户
- (void)pushToRegisterVC{
    [MBProgressHUD showError:@"该功能暂未开放"];
    //    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    //    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark 忘记密码
- (void)pushToForgetVC{
    [MBProgressHUD showError:@"该功能暂未开放"];
//    ForgetViewController *forgetVC = [[ForgetViewController alloc]init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
    
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
