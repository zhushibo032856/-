//
//  BillTableViewCell.m
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "BillTableViewCell.h"

@implementation BillTableViewCell

- (void)setDataForCellWith:(BillModel *)model{
    NSLog(@"%@",model.updateTime);
 
        NSString *dayStr = [model.updateTime substringWithRange:NSMakeRange(8, 2)];
        NSString *yeahStr = [model.updateTime substringWithRange:NSMakeRange(0, 4)];
        NSString *monthStr = [model.updateTime substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStr = [model.updateTime substringWithRange:NSMakeRange(11, 5)];
        self.DayLable.text = [NSString stringWithFormat:@"%@日",dayStr];
        self.YeahMonthLable.text = [NSString stringWithFormat:@"%@/%@",yeahStr,monthStr];
        self.TimeLable.text = [NSString stringWithFormat:@"%@",timeStr];

        self.MoneyLable.text = [NSString stringWithFormat:@"+%@",model.money];

    if ([model.status integerValue] == 1) {
        self.StatusLable.text = @"已到账";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
