//
//  DepositTableViewCell.h
//  WaterCube
//
//  Created by apple on 2019/5/29.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DepositModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DepositTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLable;

@property (weak, nonatomic) IBOutlet UIButton *RefundBT;

- (void)setDataForCellWith:(DepositModel *)model;

@end

NS_ASSUME_NONNULL_END
