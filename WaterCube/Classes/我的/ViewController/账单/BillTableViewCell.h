//
//  BillTableViewCell.h
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DayLable;
@property (weak, nonatomic) IBOutlet UILabel *YeahMonthLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLable;
@property (weak, nonatomic) IBOutlet UILabel *StatusLable;

- (void)setDataForCellWith:(BillModel *)model;

@end

NS_ASSUME_NONNULL_END
