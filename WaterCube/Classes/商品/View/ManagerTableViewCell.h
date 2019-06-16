//
//  ManagerTableViewCell.h
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerModel.h"

typedef void(^AddBlock)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface ManagerTableViewCell : UITableViewCell

@property (nonatomic, copy) AddBlock block;
@property (nonatomic, assign) NSInteger index;

@property (weak, nonatomic) IBOutlet UIImageView *TypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLable;
@property (weak, nonatomic) IBOutlet UILabel *PriceLable;
@property (weak, nonatomic) IBOutlet UILabel *CountLable;
@property (weak, nonatomic) IBOutlet UIButton *AddBT;

- (void)setDataForCellWith:(ManagerModel *)model;

@end

NS_ASSUME_NONNULL_END
