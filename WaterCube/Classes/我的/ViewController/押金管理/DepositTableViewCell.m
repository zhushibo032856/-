//
//  DepositTableViewCell.m
//  WaterCube
//
//  Created by apple on 2019/5/29.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "DepositTableViewCell.h"

@implementation DepositTableViewCell

- (void)setDataForCellWith:(DepositModel *)model{
    self.UserImage.layer.masksToBounds = YES;
    self.UserImage.layer.cornerRadius = 25;
    [self.UserImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headImg]]];
    
    self.UserName.text = [NSString stringWithFormat:@"%@",model.nickName];
    self.PhoneLable.text = [NSString stringWithFormat:@"%@",model.phone];
    self.MoneyLable.text = [NSString stringWithFormat:@"%@元",model.money];
    
}

- (IBAction)RefundBtAction:(UIButton *)sender {
    
    
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
