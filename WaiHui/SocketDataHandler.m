//
//  SocketDataHandler.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/15.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "SocketDataHandler.h"
static dispatch_queue_t _queue;
static NSMutableArray *_dataList;

@implementation SocketDataHandler
//单例
+ (instancetype)shareInstance
{
    static SocketDataHandler *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _dataList = [NSMutableArray array];
        _queue = dispatch_queue_create("com.person.syncQueue", DISPATCH_QUEUE_SERIAL);

    }
    return self;
}

- (void)setDataList:(NSMutableArray *)dataList
{
    dispatch_sync(_queue, ^{
        _dataList = [dataList mutableCopy];
    });
    
}

- (NSMutableArray *)dataList{
    __block NSMutableArray *marray;
    dispatch_sync(_queue, ^{
        marray = _dataList;
    });
    return marray;
    
}

@end
