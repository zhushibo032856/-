//
//  BillViewController.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableViewCell.h"
#import "BillDetailTableViewCell.h"
#import "BillModel.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger thePage;

@end

static NSString * const billCell = @"BillTableViewCell";
static NSString * const billDetailCell = @"BillDetailTableViewCell";

@implementation BillViewController

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
    
    self.navigationItem.title = @"账单";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self setRefreshWith];
}

- (void)leftBarBtnClicked:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setRefreshWith{
    
    _thePage = 1;
    __block typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_footer resetNoMoreData];
        weakself.thePage = 1;
        
        [weakself requestDataFromNet];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.thePage += 1;
        [weakself requestDataFromNet];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView reloadData];
    
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - kNavHeight - 10) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kColor(245, 245, 245);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"BillTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:billCell];
    [_tableView registerNib:[UINib nibWithNibName:@"BillDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:billDetailCell];
    [self.view addSubview:_tableView];
    
}

- (void)requestDataFromNet{
    
    NSDictionary *partner = @{
                              @"currentPage": @(_thePage),
                              @"mchNo": KSHOPMCHNUMBER,
                              @"size": @(10)
                              };
    NSString *url = [NSString stringWithFormat:@"%@/api/a/merchantBill/listByMchNo",KFORMALURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:KUSERTOKEN forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:partner progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errorCode"] isEqualToString:@"200"]) {
            if (self.thePage == 1) {
                [self.dataArr removeAllObjects];
            }
            
            NSDictionary *data = responseObject[@"data"];
            NSArray *arr = data[@"records"];
            for (NSDictionary *dic in arr) {
                BillModel *model = [[BillModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            if (self.thePage == 1) {
                [self.tableView.mj_header endRefreshing];
            }else{
                if (arr.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
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
        BillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:billDetailCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        return cell;
    }else{
        
        BillModel *model = _dataArr[indexPath.section];
        
        BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:billCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        [cell setDataForCellWith:model];
        return cell;
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
