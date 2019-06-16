//
//  DistributionManagementTableViewCell.m
//  WaterCube
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "DistributionManagementTableViewCell.h"

@implementation DistributionManagementTableViewCell

- (void)setdataForCellWith:(DistributionModel *)model{
    
    self.DelegateBT.layer.masksToBounds = YES;
    self.DelegateBT.layer.cornerRadius = 8;
    self.DelegateBT.layer.borderColor = kColor(240, 240, 240).CGColor;
    self.DelegateBT.layer.borderWidth = 0.5;
    
    self.NameLable.text = [NSString stringWithFormat:@"%@",model.name];
    self.PhoneLable.text = [NSString stringWithFormat:@"%@",model.phone];
    
}


- (IBAction)DelegateBtAction:(UIButton *)sender {
    
    _block(_index);
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
