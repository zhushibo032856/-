//
//  ManagerTableViewCell.m
//  WaterCube
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "ManagerTableViewCell.h"

@implementation ManagerTableViewCell

- (void)setDataForCellWith:(ManagerModel *)model{
    
    [self.TypeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imgUrl]]];
    self.NameLable.text = [NSString stringWithFormat:@"%@",model.name];
    self.PriceLable.text = [NSString stringWithFormat:@"价格 %@元",model.sellPrice];
    self.CountLable.text = [NSString stringWithFormat:@"库存 %@/%@",model.standard,model.sellNum];
}


- (IBAction)BlockBtAction:(UIButton *)sender {
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
