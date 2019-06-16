//
//  AFManegerHelp.m
//  AF3.0封装
//
//  Created by syq on 16/2/29.
//  Copyright © 2016年 syq. All rights reserved.
//
#define uploadBaseURLStr @"http://192.168.31.66:7000/api/b/image/uploadGoodsImage"

#import "AFManegerHelp.h"


@implementation AFManegerHelp

+(instancetype )shareAFManegerHelp{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
+ (void)XYJPOST:(NSString *)urlStr parameters:(id)parameters  progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObjeck))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
   
}



-(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {//并且code = 正确
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
-(void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    
    
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

//配置AFManager
-(AFHTTPSessionManager *)AFHTTPSessionManager{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
  //  [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return manager;
}
/**
 *  类方法实现
 */

+(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];

    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {//并且code = 正确
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
//POST请求
+(void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject[@"data"] isKindOfClass:[NSNull class]]) {
//
//        }else{
//            success(responseObject);
//        }
        if (success) {
            success(responseObject);

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
       
    }];

    
}

+(AFHTTPSessionManager *)AFHTTPSessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
  //  [manager.requestSerializer setValue:@"KUSERTOKEN" forHTTPHeaderField:@"TOKEN"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    

    return manager;
}

/**
 *  代理回调实现
 */
-(void)Get:(NSString *)URLString parameters:(id)parameters{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(aFManegerHelp:successResponseObject:)]) {//并且code = 正确
            [self.delegate aFManegerHelp:self successResponseObject:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(aFManegerHelp:error:)]) {
            [self.delegate aFManegerHelp:self error:error];
        }
    }];

}
//图片上传接口实现
+(void)asyncUploadFileWithData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(SuccessUploadImageBlock)success failture:(FailtureUploadImageBlock)failture{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"image/jpeg", @"image/png", nil];
    
    [manager POST:[NSString stringWithFormat:@"%@api/b/image/uploadGoodsImage?name=%@",KUPLOADIMAGE,fileName] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //fileName:上传图片名称 fileName.jpg
        /*
        fileName 类型对应下面 mimeType
         
         //例如：png格式对应--	image/png

         */
        
        
        //mimeType:格式 image/jpeg
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---%llu---%llu",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        if (failture) {
            failture(error);
        }
    }];
}


#pragma mark - MBHUD
+ (void)Hud:(NSString *)showText Delay:(NSTimeInterval)delay{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    [window addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = showText;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:delay];
}

@end
