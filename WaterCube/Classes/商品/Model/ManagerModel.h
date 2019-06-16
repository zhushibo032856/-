//
//  ManagerModel.h
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerModel : NSObject

@property (nonatomic, strong) NSString *brandCode;
@property (nonatomic, strong) NSString *catCode;
@property (nonatomic, strong) NSString *goodsCode;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sellPrice;
@property (nonatomic, strong) NSString *sellNum;
@property (nonatomic, strong) NSString *standard;

@end

NS_ASSUME_NONNULL_END
