//
//  PendingReceiptTableViewCell.h
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PendingModel.h"



typedef void(^PendingBlock)(NSInteger index,NSInteger Bttag);
NS_ASSUME_NONNULL_BEGIN

@interface PendingReceiptTableViewCell : UITableViewCell

@property (nonatomic, copy) PendingBlock block;
@property (nonatomic, assign) NSInteger index;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UIButton *CallBT;//500
@property (weak, nonatomic) IBOutlet UILabel *StatusLable;
@property (weak, nonatomic) IBOutlet UIImageView *ShopImage;
@property (weak, nonatomic) IBOutlet UILabel *ShopNameLable;
@property (weak, nonatomic) IBOutlet UILabel *ShopCountLable;
@property (weak, nonatomic) IBOutlet UILabel *ShopPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *AddressLable;
@property (weak, nonatomic) IBOutlet UIButton *CancelBT;//600
@property (weak, nonatomic) IBOutlet UIButton *JiedanBT;//700

- (void)setDataForCellWith:(PendingModel *)model;

@end

NS_ASSUME_NONNULL_END
