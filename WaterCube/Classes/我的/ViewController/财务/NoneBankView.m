//
//  NoneBankView.m
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "NoneBankView.h"

@implementation NoneBankView

+ (instancetype)SetHeadView {
    return [[[NSBundle mainBundle] loadNibNamed:@"NoneBankView" owner:nil options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
