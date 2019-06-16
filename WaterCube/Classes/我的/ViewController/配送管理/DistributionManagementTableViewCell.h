//
//  DistributionManagementTableViewCell.h
//  WaterCube
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributionModel.h"

typedef void(^deleBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface DistributionManagementTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) deleBlock block;

@property (weak, nonatomic) IBOutlet UILabel *NameLable;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLable;
@property (weak, nonatomic) IBOutlet UIButton *DelegateBT;

- (void)setdataForCellWith:(DistributionModel *)model;

@end

NS_ASSUME_NONNULL_END
