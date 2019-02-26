//
//  CashInModel.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/4.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashInModel : NSObject
@property (nonatomic,copy) NSString *rate;
@property (nonatomic,strong) NSArray *mt4_id;

@end

NS_ASSUME_NONNULL_END
