//
//  BillModel.h
//  WaterCube
//
//  Created by apple on 2019/6/15.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillModel : NSObject

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
