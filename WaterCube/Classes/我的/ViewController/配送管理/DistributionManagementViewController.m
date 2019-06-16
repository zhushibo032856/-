//
//  DistributionManagementViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "DistributionManagementViewController.h"
#import "AddDistributionViewController.h"
#import "DistributionManagementTableViewCell.h"
#import "AddDistributionTableViewCell.h"
#import "DistributionModel.h"

@interface DistributionManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

static NSString * const disCell = @"DistributionManagementTableViewCell";
static NSString * const addCell = @"AddDistributionTableViewCell";

@implementation DistributionManagementViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_itemBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"水站信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self requestDataFromNet];
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - kNavHeight - KTabbarHeight - 10) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kColor(245, 245, 245);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DistributionManagementTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:disCell];
    [_tableView registerNib:[UINib nibWithNibName:@"AddDistributionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:addCell];
    [self.view addSubview:_tableView];
    
}

- (void)requestDataFromNet{
    NSString *url = [NSString stringWithFormat:@"%@/api/a/hamal/listByMchNo?mchNo=%@",KFORMALURL,KSHOPMCHNUMBER];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [self.dataArr removeAllObjects];
            NSArray *arr = responseObject[@"data"];
           // NSLog(@"%@",arr);
            for (NSDictionary *dic in arr) {
                DistributionModel *model = [[DistributionModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            
        }else{
            [MBProgressHUD showError:@"查询失败"];
        }
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == _dataArr.count) {
        return 50;
    }
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == _dataArr.count) {
        AddDistributionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        return cell;
    }else{
        DistributionModel *model = _dataArr[indexPath.section];
        DistributionManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:disCell forIndexPath:indexPath];
        [cell setdataForCellWith:model];
        cell.selectionStyle = NO;
        cell.index = indexPath.section;
        __weak typeof(self)weakSelf = self;
        cell.block = ^(NSInteger index) {
            [weakSelf deleGateWith:index];
        };
        
        return cell;
    }
}

- (void)deleGateWith:(NSInteger)index{
    DistributionModel *model = _dataArr[index];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/a/hamal/deleteByPhone?phone=%@",KFORMALURL,model.phone];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"删除成功"];
            [self requestDataFromNet];
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == _dataArr.count ) {
        self.hidesBottomBarWhenPushed = YES;
        AddDistributionViewController *addVC = [AddDistributionViewController new];
        
        [self.navigationController pushViewController:addVC animated:YES];
    }
    
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
