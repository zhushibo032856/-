//
//  PendingReceiptTableViewCell.m
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "PendingReceiptTableViewCell.h"

@implementation PendingReceiptTableViewCell


- (void)setDataForCellWith:(PendingModel *)model{
    
    
    
}

- (IBAction)PendingBtAction:(UIButton *)sender {
    
    _block(_index,sender.tag);
    
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
