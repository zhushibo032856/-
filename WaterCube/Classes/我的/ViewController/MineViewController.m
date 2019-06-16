//
//  MineViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "QuitLoginTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "WaterShopMessageViewController.h"
#import "DepositManagementViewController.h"
#import "DistributionManagementViewController.h"
#import "SecuritySettingViewController.h"
#import "FinanceViewController.h"
#import "BillViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}

@property (weak, nonatomic) IBOutlet UIView *HeadView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIImageView *ShopImageView;
@property (weak, nonatomic) IBOutlet UILabel *ShopNameLable;
@property (weak, nonatomic) IBOutlet UIButton *MessageBT;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *WalletTap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *BillTap;

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString * const mineCell = @"MineTableViewCell";
static NSString * const quitCell = @"QuitLoginTableViewCell";

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ShopNameLable.text = [NSString stringWithFormat:@"%@",KUSERNAME];
    [self.ShopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KUSERIMAGEURL]] placeholderImage:[UIImage imageNamed:@""]];
    
    [self getLocation];
    [self initTableView];
    // Do any additional setup after loading the view.
}



- (IBAction)MessageBtAction:(UIButton *)sender {
    [self getLocation];
}

-(void)getLocation{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
  //  NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self->currentCity = placeMark.locality;
            if (!self->currentCity) {
                self->currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            //            NSLog(@"----%@",placeMark.country);//当前国家
            //            NSLog(@"%@",self->currentCity);//当前的城市
            //            NSLog(@"%@",placeMark.subLocality);//当前的位置
            //            NSLog(@"%@",placeMark.thoroughfare);//当前街道
         //   NSLog(@"%@",placeMark.name);//具体地址
            [self.MessageBT setTitle:placeMark.name forState:UIControlStateNormal];
        }
    }];
    
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _SecondView.bottom + 20, kScreenWidth, kScreenHeight - kNavHeight - KTabbarHeight - _SecondView.height - _HeadView.height - 20) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kColor(245, 245, 245);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:mineCell];
    [_tableView registerNib:[UINib nibWithNibName:@"QuitLoginTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:quitCell];
    
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *nameArr = @[@"水站信息",@"押金管理",@"配送管理",@"安全设置"];
        cell.TypeLable.text = nameArr[indexPath.row];
        NSArray *imageArr = @[@"manager_2",@"manager_4",@"manager_3",@"manager_5"];
        [cell.TypeImage setImage:[UIImage imageNamed:imageArr[indexPath.row]]];
        return cell;
    }else{
        QuitLoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:quitCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WaterShopMessageViewController *waterVC = [[WaterShopMessageViewController alloc]init];
            [self.navigationController pushViewController:waterVC animated:YES];
        }else if (indexPath.row == 1){
            DepositManagementViewController *depVC = [[DepositManagementViewController alloc]init];
            [self.navigationController pushViewController:depVC animated:YES];
        }else if (indexPath.row == 2){
            DistributionManagementViewController *disVC = [[DistributionManagementViewController alloc]init];
            [self.navigationController pushViewController:disVC animated:YES];
        }else if(indexPath.row == 3){
            SecuritySettingViewController *secVC = [[SecuritySettingViewController alloc]init];
            [self.navigationController pushViewController:secVC animated:YES];
        }
    }else{
        [self quitLogin];
    }
    self.hidesBottomBarWhenPushed = NO;
}

- (void)quitLogin{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/b/merchantSso/logout?token=%@",KFORMALURL,KUSERTOKEN];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            
            [kUserDefaults removeObjectForKey:@"token"];
            [kUserDefaults removeObjectForKey:@"shopType"];
            [kUserDefaults removeObjectForKey:@"shopImage"];
            [kUserDefaults removeObjectForKey:@"shopName"];
            [kUserDefaults removeObjectForKey:@"mchNumber"];
            [kUserDefaults removeObjectForKey:@"shopNumber"];
            [kUserDefaults removeObjectForKey:@"ID"];
            [kUserDefaults removeObjectForKey:@"city"];
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





- (IBAction)WalletTapAction:(UITapGestureRecognizer *)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    FinanceViewController *finVC = [[FinanceViewController alloc]init];
    [self.navigationController pushViewController:finVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)BillTapAction:(UITapGestureRecognizer *)sender {
    self.hidesBottomBarWhenPushed = YES;
    BillViewController *billVC = [[BillViewController alloc]init];
    [self.navigationController pushViewController:billVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
