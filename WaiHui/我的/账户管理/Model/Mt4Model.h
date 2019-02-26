//
//  Mt4Model.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/7.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountBalance.h"

@class Mt4Info;
NS_ASSUME_NONNULL_BEGIN

@interface Mt4Model : NSObject

@property(nonatomic,copy) NSString *mt4_id;
@property(nonatomic,assign) int user_type;
@property(nonatomic,assign) int is_default;
@property(nonatomic,assign) int is_login;


@property(nonatomic,strong) Mt4Info *mt4info;
@property(nonatomic,copy) NSString *withdrawal;
@property(nonatomic,copy) NSString *recharge;
@property(nonatomic,copy) NSString *standard_volume;
@property(nonatomic,copy) NSString *balance;
@property(nonatomic,copy) NSString *leverage;
@property (nonatomic,strong) AccountBalance *blanceCount;
@property (nonatomic,copy) void(^reloadBlock)(void) ;
@property (nonatomic,assign) double income;
@property (nonatomic,assign) BOOL isCount;


@end

@interface Mt4Info : NSObject
@property(nonatomic,copy) NSString *NAME;
@property(nonatomic,copy) NSString *BALANCE;
@property(nonatomic,copy) NSString *LEVERAGE;
@property(nonatomic,copy) NSString *LOGIN;
@property(nonatomic,copy) NSString *CURRENCY;
@property(nonatomic,copy) NSString *usertype;

@end

NS_ASSUME_NONNULL_END
