//
//  Mt4Balance.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/9.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mt4Balance : NSObject
@property (nonatomic,copy) NSString *balance;
@property (nonatomic,copy) NSString *cmd;
@property (nonatomic,copy) NSString *equity;
@property (nonatomic,copy) NSString *group;
@property (nonatomic,copy) NSString *leverage;
@property (nonatomic,copy) NSString *login;
@property (nonatomic,copy) NSString *margin;
@property (nonatomic,copy) NSString *margin_free;
@property (nonatomic,copy) NSString *margin_level;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,assign) int ret;




@end

NS_ASSUME_NONNULL_END
