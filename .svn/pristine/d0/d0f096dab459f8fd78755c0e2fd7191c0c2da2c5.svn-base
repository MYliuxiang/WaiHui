//
//  LoginHandle.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/9.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "LoginHandle.h"

@implementation LoginHandle
//单例
+ (instancetype)shareInstance
{
    static LoginHandle *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}
@end
