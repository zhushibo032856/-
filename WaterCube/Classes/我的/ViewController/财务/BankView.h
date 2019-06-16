//
//  BankView.h
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankView : UIView

+ (instancetype)SetHeadView;

@property (weak, nonatomic) IBOutlet UIView *FirstView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;
@property (weak, nonatomic) IBOutlet UILabel *BankName;
@property (weak, nonatomic) IBOutlet UILabel *BankNumber;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *BillTap;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *EditBankTap;

@end

NS_ASSUME_NONNULL_END
