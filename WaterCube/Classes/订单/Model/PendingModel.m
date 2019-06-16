//
//  PendingModel.m
//  WaterCube
//
//  Created by apple on 2019/6/16.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#import "PendingModel.h"

@implementation ShopModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

@implementation PendingModel

- (NSMutableArray *)arr {
    if (!_arr) {
        self.arr = [NSMutableArray arrayWithCapacity:0];
    }
    return _arr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"orderItemList"]) {
        NSArray *arr = value;
        for (NSDictionary *xd in arr) {
            ShopModel *model = [ShopModel new];
            [model setValuesForKeysWithDictionary:xd];
            [self.arr addObject:model];
        }
    }
}

- (void)setNilValueForKey:(NSString *)key{
    [self setValue:@"" forKey:key];
}

@end
