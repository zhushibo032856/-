//
//  PendingModel.h
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PendingModel : NSObject

@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *bookTime;
@property (nonatomic, strong) NSString *payMoney;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *couponMoney;
@property (nonatomic, strong) NSString *receiptAddress;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *payStatus;
@property (nonatomic, strong) NSString *completeTime;
@property (nonatomic, strong) NSString *distributionTime;

@property (nonatomic, strong) NSMutableArray *arr;//存储订单中商品数组

@end

@interface ShopModel : NSObject

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sellPrice;
@property (nonatomic, strong) NSString *goodsCode;

@end


NS_ASSUME_NONNULL_END
