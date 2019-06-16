//
//  AllOrderViewController.m
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "AllOrderViewController.h"
#import "PendingReceiptTableViewCell.h"
#import "DeliveryTableViewCell.h"
#import "CompletedTableViewCell.h"
#import "PendingModel.h"

@interface AllOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger thePage;

@end

static NSString * const pendingCell = @"PendingReceiptTableViewCell";
static NSString * const deliveryCell = @"DeliveryTableViewCell";
static NSString * const completCell = @"CompletedTableViewCell";

@implementation AllOrderViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self setRefreshWith];
    // Do any additional setup after loading the view.
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - kNavHeight - KTabbarHeight - 10) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = kColor(245, 245, 245);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"PendingReceiptTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:pendingCell];
    [_tableView registerNib:[UINib nibWithNibName:@"DeliveryTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:deliveryCell];
    [_tableView registerNib:[UINib nibWithNibName:@"CompletedTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:completCell];
    [self.view addSubview:_tableView];
    
}

- (void)requestDataFromNet{
    
    NSDictionary *partner = @{
                              @"currentPage": @(_thePage),
                              @"mchNo": KSHOPMCHNUMBER,
                              @"size": @(10)
                              };
    NSString *url = [NSString stringWithFormat:@"%@/api/a/order/listOrderByMchNo",KFORMALURL];
    
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
                PendingModel *model = [[PendingModel alloc]init];
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
    
    PendingModel *model = _dataArr[indexPath.section];
    if ([model.orderStatus integerValue] == 0 || [model.orderStatus integerValue] == 1) {
        return 200;
    }
    return 150;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PendingModel *model = _dataArr[indexPath.section];
        
    if ([model.orderStatus integerValue] == 0) {
        PendingReceiptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pendingCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        
        return cell;
    }else if ([model.orderStatus integerValue] == 1){
        
        DeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deliveryCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
        return cell;
        
    }else{
        CompletedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:completCell forIndexPath:indexPath];
        cell.selectionStyle = NO;
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
