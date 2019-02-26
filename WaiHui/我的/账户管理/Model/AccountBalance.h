//
//  AccountBalance.h
//  WaiHui
//
//  Created by liuxiang on 2019/2/21.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountBalance : NSObject

@property(nonatomic,copy) NSString *mt4ID;
@property (nonatomic,copy) void(^balanceBlock)(double balance) ;

@end

NS_ASSUME_NONNULL_END
