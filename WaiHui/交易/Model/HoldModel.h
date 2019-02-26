//
//  HoldModel.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/11.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoldModel : NSObject

@property(nonatomic,assign) BOOL isOpen;


@property(nonatomic,copy) NSString *close_price;
@property(nonatomic,copy) NSString *close_time;
@property(nonatomic,copy) NSString *command;
@property(nonatomic,copy) NSString *comment;
@property(nonatomic,copy) NSString *commission;
@property(nonatomic,copy) NSString *digits;
@property(nonatomic,copy) NSString *open_price;
@property(nonatomic,copy) NSString *open_time;
@property(nonatomic,copy) NSString *order;
@property(nonatomic,copy) NSString *profit;
@property(nonatomic,copy) NSString *sl; //止损
@property(nonatomic,copy) NSString *symbol;
@property(nonatomic,copy) NSString *symbolName;
@property(nonatomic,copy) NSString *taxes;
@property(nonatomic,copy) NSString *tp; //止盈
@property(nonatomic,copy) NSString *volume;
@property(nonatomic,copy) NSString *storage;
@property(nonatomic,copy) NSString *ask;


@property(nonatomic,assign) int ask_state;
@property(nonatomic,copy) NSString *balance;
@property(nonatomic,copy) NSString *bid;
@property(nonatomic,assign) int bid_state;
@property(nonatomic,copy) NSString *contract_size;
@property(nonatomic,copy) NSString *currency;
@property(nonatomic,copy) NSString *leverage;
@property(nonatomic,copy) NSString *lot_max;
@property(nonatomic,copy) NSString *lot_min;
@property(nonatomic,copy) NSString *lot_step;
@property(nonatomic,copy) NSString *margin_divider;
@property(nonatomic,copy) NSString *margin_initial;
@property(nonatomic,copy) NSString *margin_mode;
@property(nonatomic,copy) NSString *spread;
@property(nonatomic,copy) NSString *stops_level;
@property(nonatomic,copy) NSString *swap_long;
@property(nonatomic,copy) NSString *swap_rollover3days;
@property(nonatomic,copy) NSString *swap_short;
@property(nonatomic,copy) NSString *tick_size;
@property(nonatomic,copy) NSString *tick_value;
@property(nonatomic,copy) NSString *tradeTime;
@property(nonatomic,copy) NSString *profit_mode;




@end

NS_ASSUME_NONNULL_END
