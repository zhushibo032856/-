//
//  DeliveryTableViewCell.h
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UIButton *CallBT;//5000
@property (weak, nonatomic) IBOutlet UILabel *StatusLable;
@property (weak, nonatomic) IBOutlet UIImageView *ShopImage;
@property (weak, nonatomic) IBOutlet UILabel *ShopNameLable;
@property (weak, nonatomic) IBOutlet UILabel *ShopCountLable;
@property (weak, nonatomic) IBOutlet UILabel *ShopPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *DeliveryPeople;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *AddressLable;
@property (weak, nonatomic) IBOutlet UIButton *CompletBT;
@property (weak, nonatomic) IBOutlet UIButton *MapBT;



@end

NS_ASSUME_NONNULL_END
