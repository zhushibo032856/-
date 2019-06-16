//
//  NoneBankView.h
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoneBankView : UIView

+ (instancetype)SetHeadView;

@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *AddBankTap;

@end

NS_ASSUME_NONNULL_END
