//
//  LoginHandle.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/9.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginHandle : NSObject

@property(nonatomic,assign) BOOL loginOperation;

+ (instancetype)shareInstance;//单例

@end

NS_ASSUME_NONNULL_END
