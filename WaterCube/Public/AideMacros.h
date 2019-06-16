//
//  AideMacros.h
//  HXEDigitalRestaurant
//
//  Created by apple on 2019/1/26.
//  Copyright © 2019年 aladdin. All rights reserved.
//

#ifndef AideMacros_h
#define AideMacros_h

/** Estimate Is Null */
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 || [str isEqualToString:@""]||[str isEqualToString:@"null"] ? YES : NO )
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


/** Screen Size */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kCurrentDevice [[[UIDevice currentDevice] systemVersion] floatValue]
//#define iPhoneX ((kScreenWidth == 375 && kScreenHeight == 812) ? YES : NO)

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone XR
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone XS
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone X Max
#define iPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
//iPhoneX系列
#define NavgationHeight 44.0f
#define STATUS_BAR_HEIGHT ((iPhoneX==YES || iPhoneXR ==YES || iPhoneXS== YES || iPhoneXMax== YES) ? 44.0 : 20.0)
#define kNavHeight ((iPhoneX==YES || iPhoneXR ==YES || iPhoneXS== YES || iPhoneXMax== YES) ? 88.0 : 64.0)
#define KTabbarHeight ((iPhoneX==YES || iPhoneXR ==YES || iPhoneXS== YES || iPhoneXMax== YES) ? 83.0 : 49.0)


/** Scale Width / Height */
#define kNav_H kScreenHeight > 668 ? 86 : 64
#define kTabbar_H kScreenHeight > 668 ? 59 : 49
#define ScaleNumberWidth kScreenWidth / 375
#define ScaleNumberHeight  (iPhoneX ? kScreenHeight / 812 :  kScreenHeight / 667)
#define kSNavHeight (iPhoneX ? 22 : 0)
#define kSVerticalHeight(n) (iPhoneX ? 22 + 145 / n : 0)
/** Setting Color */
#define CRColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


/** RGB Color Value Settings */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/** Common Color */
#define kBrownColor UIColorFromRGB(0xd9c091)
#define kTitleColor UIColorFromRGB(0x1a1a1a)
#define kTextColor CRColor(29.f, 29.f, 29.f)
#define kTextColorLight UIColorFromRGB(0x544c3b)
#define kNavColor UIColorFromRGB(0xf0eff4)
#define kLineColor CRColor(230.f, 230.f, 230.f)
#define kBackColor CRColor(249.f, 249.f, 246.f)
#define kGreenColor UIColorFromRGB(0x14bf7d)
#define kTimeColor UIColorFromRGB(0x5a5a5a)
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

/** Set The Random Color */
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


/** iPhone Version */
#define iPhone4S ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5S ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone6S ([UIScreen mainScreen].bounds.size.height == 667)
#define iPhone6pS ([UIScreen mainScreen].bounds.size.height == 736)


/** NSlog */
#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif


/** Common Font */
#define FontType_Text(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define FontType_Title(s) [UIFont fontWithName:@"PingFangHK-Regular" size:s]
#define FontType_Bold(s) [UIFont fontWithName:@"PingFangSC-Semibold" size:s]

#define FontName_Text @"PingFangSC-Light"
#define FontName_Title @"PingFangHK-Regular"
#define FontName_Bold @"PingFangSC-Semibold"


/** Some Abbreviations */
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]


/** local Data */
#define KDEVICETOKEN    [kUserDefaults valueForKey:@"deviceToken"]//deviceToken
#define KSHOPTYPE       [kUserDefaults valueForKey:@"shopType"] // 用户类型
#define KUSERTOKEN      [kUserDefaults valueForKey:@"token"] //token值
#define KUSERPHONE      [kUserDefaults valueForKey:@"phone"] //电话
#define KUSERPASSWORD   [kUserDefaults valueForKey:@"password"] //密码
#define KUSERIMAGEURL   [kUserDefaults valueForKey:@"shopImage"] //店铺图像
#define KUSERNAME       [kUserDefaults valueForKey:@"shopName"] //店铺名称
#define KSHOPMCHNUMBER  [kUserDefaults valueForKey:@"mchNumber"] //商户号
#define KSHOPNUMBER     [kUserDefaults valueForKey:@"shopNumber"] // 店铺编号
#define KSHIPID         [kUserDefaults valueForKey:@"ID"] //sso 中的id
#define KSHOPCITY       [kUserDefaults valueForKey:@"city"] //城市代号

/** UserDefaults */
#define kUserDefaults       [NSUserDefaults standardUserDefaults]


/** App Version */
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/** Archive Storage Path */
#define SavePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"/user.txt"])


/** Weak References / Strong References */
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong typeof(type) type = weak##type;

#endif /* AideMacros_h */
