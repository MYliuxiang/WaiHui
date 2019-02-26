//
//  BankInfo.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/23.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankInfo : NSObject
@property (nonatomic,copy) NSString *bank_name;
@property (nonatomic,copy) NSString *bank_number;
@property (nonatomic,copy) NSString *auth_status;
@end

NS_ASSUME_NONNULL_END
