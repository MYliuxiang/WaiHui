//
//  HandleTool.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/4.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NUMBERSPERIOD @"0123456789."

NS_ASSUME_NONNULL_BEGIN

@interface HandleTool : NSObject
+(BOOL) isNumber:(NSString *)string;
+(BOOL) isPhone:(NSString *)string;
+(BOOL) isEmail:(NSString *)string;
+(BOOL) inputNum:(NSString *)string;

+(NSString *)dateToOld:(NSDate *)bornDate;

+(BOOL)isMobileNumber:(NSString *)mobileNum;


+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
                          withDateFormat:(NSString *)dateFormat
;

/*
 返回0、1、2 3为格式不正确，返回4为密码格式正确
 0长度不正确
 1没有大写或小写
 2含有特殊字符
 3没有数字
 */

+(int)checkIsHaveNumAndLetter:(NSString*)password;


//字典转json处理訊息字段
+ (NSString*)convertToJSONData:(id)infoDict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//星座算法
+ (NSString *)getXingzuo:(NSDate *)in_date;
+ (NSArray *)getpreferOptions;

//处理活跃时间
+ (NSString *)handleActiveWith:(NSString *)times;

//处理浮点位数为0的情况
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue;

//获取当前显示的控制器
+ (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
