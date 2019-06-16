//
//  ManagerViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "ManagerViewController.h"
#import "ManagerTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "AddCountViewController.h"

@interface ManagerViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}

@property (weak, nonatomic) IBOutlet UIView *HeadView;
@property (weak, nonatomic) IBOutlet UIImageView *ShopImageView;
@property (weak, nonatomic) IBOutlet UILabel *ShopNameLable;
@property (weak, nonatomic) IBOutlet UIButton *MessageBt;
@property (weak, nonatomic) IBOutlet UILabel *StatusLable;
@property (weak, nonatomic) IBOutlet UISwitch *StatusSwitch;
@property (weak, nonatomic) IBOutlet UIButton *AddBT;
@property (weak, nonatomic) IBOutlet UIView *SecondView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

static NSString *const managerCell = @"ManagerTableViewCell";

@implementation ManagerViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ShopNameLable.text = [NSString stringWithFormat:@"%@",KUSERNAME];
    [self.ShopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KUSERIMAGEURL]] placeholderImage:[UIImage imageNamed:@""]];
    
    [self getLocation];
    [self initTableView];
    
    [self requestDataFromNet];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)LocationBtAction:(UIButton *)sender {
    [self getLocation];
}

-(void)getLocation
{
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
 //   NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
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
     //       NSLog(@"%@",placeMark.name);//具体地址
            [self.MessageBt setTitle:placeMark.name forState:UIControlStateNormal];
        }
    }];
    
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _SecondView.bottom + 10, kScreenWidth, kScreenHeight - _HeadView.height - _SecondView.height - 10 - kNavHeight - KTabbarHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kColor(245, 245, 245);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ManagerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:managerCell];
    
    [self.view addSubview:_tableView];
    
}

- (void)requestDataFromNet{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/goods/listByCity?city=%@",KFORMALURL,KSHOPCITY];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  NSLog(@"%@",responseObject);
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [self.dataArr removeAllObjects];
            NSArray *arr = responseObject[@"data"];
            for (NSDictionary *dic in arr) {
                ManagerModel *model = [[ManagerModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerModel *model = _dataArr[indexPath.section];
    ManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:managerCell forIndexPath:indexPath];
    
    cell.index = indexPath.section;
    __weak typeof(self) weakSelf = self;
    cell.block = ^(NSInteger index) {
        [weakSelf addCountWith:index];
        NSLog(@"%ld",index);
    };
    
    [cell setDataForCellWith:model];
    return cell;
}

- (void)addCountWith:(NSInteger)index{
    
    ManagerModel *model = _dataArr[index];
    self.hidesBottomBarWhenPushed = YES;
    AddCountViewController *addVC = [[AddCountViewController alloc]init];
    addVC.model = model;
    [self.navigationController pushViewController:addVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}




- (IBAction)StatusSwitchAction:(UISwitch *)sender {
    [MBProgressHUD showError:@"该功能暂未开放"];
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
