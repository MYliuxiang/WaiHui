//
//  Mt4Model.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/7.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "Mt4Model.h"

@implementation Mt4Model

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)setMt4_id:(NSString *)mt4_id
{
    _mt4_id = mt4_id;
   
}

- (void)setIsCount:(BOOL)isCount
{
    _isCount = isCount;
    if (isCount) {
        self.blanceCount = [[AccountBalance alloc] init];
        if (self.mt4_id.length == 0 || [self.mt4_id isKindOfClass:[NSNull class]] || [self.mt4_id isEqualToString:@"null"]) {
            return;
        }
        self.blanceCount.mt4ID = self.mt4_id;
        self.blanceCount.balanceBlock = ^(double balance) {
            self.income = balance;
            if (self.reloadBlock) {
                self.reloadBlock();
            }
        };
    }
}


@end
