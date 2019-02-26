//
//  TdModel.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/4.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TdModel : NSObject
@property (nonatomic,copy) NSString *payType;
@property (nonatomic,assign) float minUsdAmount;
@property (nonatomic,assign) float maxUsdAmount;
@property (nonatomic,copy) NSString *payName;
@property (nonatomic,copy) NSString *payChannelName;
@property (nonatomic,copy) NSString *bankIdRequired;
@property (nonatomic,strong) NSArray *bankList;



@end

NS_ASSUME_NONNULL_END
