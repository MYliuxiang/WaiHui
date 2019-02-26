//
//  SocketHandler.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/4.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "SocketHandler.h"
#define TCP_beatBody  @"beatID"    //心跳标识
#define TCP_AutoConnectCount  3    //自动重连次数
#define TCP_BeatDuration  1        //心跳频率
#define TCP_MaxBeatMissCount   3   //最大心跳丢失数
#define TCP_PingUrl    @"www.baidu.com"

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
//ws://192.168.0.25:8080/websocket
static NSString *const socketUrl = @"ws://192.168.0.27:8080/websocket";



NSInteger autoConnectCount = TCP_AutoConnectCount;

@interface SocketHandler ()<SRWebSocketDelegate>
@property (nonatomic, strong) NSTimer *heartBeatTimer; //心跳定时器
@property (nonatomic, strong) NSTimer *netWorkTestingTimer; //没有网络的时候检测网络定时器
@property (nonatomic, strong) dispatch_queue_t queue; //数据请求队列（串行队列）
@property (nonatomic, strong) dispatch_queue_t handlequeue; //数据处理队列（串行队列）

@property (nonatomic, assign) NSTimeInterval reConnectTime; //重连时间
@property (nonatomic, strong) NSMutableArray *sendDataArray; //存储要发送给服务端的数据
@property (nonatomic, assign) BOOL isActivelyClose;    //用于判断是否主动关闭长连接，如果是主动断开连接，连接失败的代理中，就不用执行 重新连接方法
@property (nonatomic, assign) NSInteger senBeatCount;



@end


@implementation SocketHandler
//单例
+ (instancetype)shareInstance
{
    static SocketHandler *_instace = nil;
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
        self.isActivelyClose = NO;
        self.queue = dispatch_queue_create("BF",NULL);
        self.handlequeue = dispatch_queue_create("Data",NULL);
        self.sendDataArray = [[NSMutableArray alloc] init];
        [self xw_addObserverBlockForKeyPath:@"connectStatus" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
            [self xw_postNotificationWithName:SocketNotice userInfo:@{@"state":@(self.connectStatus)}];
        }];
        
    }
    return self;
}

#pragma mark - NSTimer

//初始化心跳
- (void)initHeartBeat
{
    //心跳没有被关闭
    if(self.heartBeatTimer)
    {
        return;
    }
    
    [self destoryHeartBeat];
    
    __weak typeof(self) weakSelf = self;

    dispatch_main_async_safe(^{
        weakSelf.heartBeatTimer  = [NSTimer timerWithTimeInterval:3 target:weakSelf selector:@selector(senderheartBeat) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:weakSelf.heartBeatTimer forMode:NSRunLoopCommonModes];
    });
}

//取消心跳
- (void)destoryHeartBeat
{
    __weak typeof(self) weakSelf = self;
    dispatch_main_async_safe(^{
        if(weakSelf.heartBeatTimer)
        {
            [weakSelf.heartBeatTimer invalidate];
            weakSelf.heartBeatTimer = nil;
        }
    });
}

//没有网络的时候开始定时 -- 用于网络检测
- (void)noNetWorkStartTestingTimer
{
    __weak typeof(self) weakSelf = self;
    dispatch_main_async_safe(^{
        weakSelf.netWorkTestingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(noNetWorkStartTesting) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.netWorkTestingTimer forMode:NSDefaultRunLoopMode];
        
    });
}

////取消网络检测
- (void)destoryNetWorkStartTesting
{
    __weak typeof(self) weakSelf = self;
    dispatch_main_async_safe(^{
        if(weakSelf.netWorkTestingTimer)
        {
            [weakSelf.netWorkTestingTimer invalidate];
            weakSelf.netWorkTestingTimer = nil;
        }
    });
}

#pragma mark - private -- webSocket相关方法

//发送心跳
- (void)senderheartBeat
{
    //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
    __weak typeof(self) weakSelf = self;
    dispatch_main_async_safe((^{
        weakSelf.senBeatCount ++;
        if (weakSelf.senBeatCount > TCP_MaxBeatMissCount) {
            [weakSelf reConnectServer];
        }else{
            if(weakSelf.webSocket.readyState == SR_OPEN)
            {
                
                NSDictionary *dic = @{@"type":@"ping"};
                NSString *jsonStr = [HandleTool convertToJSONData:dic];
                [weakSelf.webSocket sendPing:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        
    }));
}

////定时检测网络
- (void)noNetWorkStartTesting
{
    //有网络
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reachability currentReachabilityStatus] != NotReachable) {
        //关闭网络检测定时器
        [self destoryNetWorkStartTesting];
        //开始重连
        [self reConnectServer];
    }
//    NSLog(@"%d",AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus); if(AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN || AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi)
//    {
//        //关闭网络检测定时器
//        [self destoryNetWorkStartTesting];
//        //开始重连
//        [self reConnectServer];
//    }
}

//建立长连接
- (void)connectServer
{
    self.isActivelyClose = NO;
    
    if(self.webSocket)
    {
        self.webSocket = nil;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:socketUrl]];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

//重新连接服务器
- (void)reConnectServer
{
    if (autoConnectCount == 0) {
        self.connectStatus = SocketConnectStatus_UnConnected;
        

        return;
    }
    
    autoConnectCount --;
    if(self.webSocket.readyState == SR_OPEN)
    {
        self.connectStatus = SocketConnectStatus_Connected;

        [self initHeartBeat]; //开启心跳
        //如果有尚未发送的数据，继续向服务端发送数据
        if ([self.sendDataArray count] > 0){
            [self sendeDataToServer];
        }
        return;
    }
    
    self.connectStatus = SocketConnectStatus_ReConnecting;


    __weak typeof(self) weakSelf = self;
    dispatch_main_async_safe(^{
        if(weakSelf.webSocket.readyState == SR_OPEN && weakSelf.webSocket.readyState == SR_CONNECTING)
        {
            return;
        }
        
        [weakSelf connectServer];
        NSLog(@"正在重连第%ld次......",TCP_MaxBeatMissCount - (long)autoConnectCount + 1);
        weakSelf.connectStatus = SocketConnectStatus_ReConnecting;

      
    });
   
    
}

//关闭连接
- (void)SRWebSocketClose;
{
    _senBeatCount = 0;
    self.isActivelyClose = YES;
    [self webSocketClose];
    //关闭心跳定时器
    [self destoryHeartBeat];
    //关闭网络检测定时器
    [self destoryNetWorkStartTesting];
}

//关闭连接
- (void)webSocketClose
{
    self.connectStatus = SocketConnectStatus_UnConnected;

    NSLog(@"连接关闭");

    if(self.webSocket)
    {
        [self.webSocket close];
        self.webSocket = nil;
    }
    autoConnectCount = TCP_AutoConnectCount;

}

//发送数据给服务器
- (void)sendDataToServer:(id)data
{
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *jsonStr = [HandleTool convertToJSONData:data];
        [self.sendDataArray addObject:jsonStr];
    }else{
        [self.sendDataArray addObject:data];
    }
    [self sendeDataToServer];
}


- (void)sendeDataToServer
{
    __weak typeof(self) weakSelf = self;
    //把数据放到一个请求队列中
    dispatch_async(self.queue, ^{
        
        Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        if ([reachability currentReachabilityStatus] == NotReachable) {
            //开启网络检测定时器
            [weakSelf noNetWorkStartTestingTimer];
            
        }
        //没有网络
//        if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
//        {
//            //开启网络检测定时器
//            [weakSelf noNetWorkStartTestingTimer];
//        }
        else //有网络
        {
            if(weakSelf.webSocket != nil)
            {
                // 只有长连接OPEN开启状态才能调 send 方法，不然会Crash
                if(weakSelf.webSocket.readyState == SR_OPEN)
                {
                    if (weakSelf.sendDataArray.count > 0)
                    {
                        NSString *data = weakSelf.sendDataArray[0];
                        [weakSelf.webSocket send:data]; //发送数据
                        [weakSelf.sendDataArray removeObjectAtIndex:0];
                        
                        if([weakSelf.sendDataArray count] > 0)
                        {
                            [weakSelf sendeDataToServer];
                        }
                    }
                }
                else if (weakSelf.webSocket.readyState == SR_CONNECTING) //正在连接
                {
                    NSLog(@"正在连接中，重连后会去自动同步数据");
                }
                else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) //断开连接
                {
                    //调用 reConnectServer 方法重连,连接成功后 继续发送数据
                    [weakSelf reConnectServer];
                }
            }else
            {
                [weakSelf connectServer]; //连接服务器
            }
        }
    });
}

#pragma mark - SRWebSocketDelegate -- webSockect代理
//连接成功回调
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"webSocket === 连接成功");
    self.connectStatus = SocketConnectStatus_Connected;

    autoConnectCount = TCP_AutoConnectCount;
    [self initHeartBeat]; //开启心跳
    //如果有尚未发送的数据，继续向服务端发送数据
    if ([self.sendDataArray count] > 0){
        [self sendeDataToServer];
    }
    NSDictionary *dic = @{@"type":@"All"};
    [self sendDataToServer:dic];
}

//连接失败回调
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{    //用户主动断开连接，就不去进行重连
    if(self.isActivelyClose)
    {
        self.connectStatus = SocketConnectStatus_UnConnected;

        return;
    }
    
    [self destoryHeartBeat]; //断开连接时销毁心跳
    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了");
// NSLog(@"%d",AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus);
    
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    // 2.判断网络状态
    if ([reachability currentReachabilityStatus] == NotReachable) {
        [self noNetWorkStartTestingTimer];
        self.connectStatus = SocketConnectStatus_UnConnected;


    } else{
        
        [self reConnectServer];

    }

}



//连接关闭,注意连接关闭不是连接断开，关闭是 [socket close] 客户端主动关闭，断开可能是断网了，被动断开的。
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    // 在这里判断 webSocket 的状态 是否为 open , 大家估计会有些奇怪 ，因为我们的服务器都在海外，会有些时间差，经过测试，我们在进行某次连接的时候，上次重连的回调刚好回来，而本次重连又成功了，就会误以为，本次没有重连成功，而再次进行重连，就会出现问题，所以在这里做了一下判断
    NSLog(@"连接关闭");

    if(self.webSocket.readyState == SR_OPEN || self.isActivelyClose)
    {
        self.connectStatus = SocketConnectStatus_UnConnected;

        return;
    }
    
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    
    [self destoryHeartBeat]; //断开连接时销毁心跳
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reachability currentReachabilityStatus] != NotReachable) {
        // 当前已连接wifi
        [self noNetWorkStartTestingTimer];
        self.connectStatus = SocketConnectStatus_UnConnected;


    } else{
        [self reConnectServer];
    }
//    [self checkNet];
//    //判断网络环境
//    if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable || AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) //没有网络
//    {
//        [self noNetWorkStartTestingTimer];//开启网络检测
//    }
//    else //有网络
//    {
//        [self reConnectServer];//连接失败就重连
//    }
}



+ (void)startSocketStaus:(SocketConnectStatusBlock)socketStausBlock
{
            [self xw_addObserverBlockForKeyPath:@"connectStatus" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
                if (socketStausBlock) {
                    socketStausBlock([SocketHandler shareInstance].connectStatus);
                }
            }];
}


//该函数是接收服务器发送的pong消息，其中最后一个参数是接受pong消息的
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData*)pongPayload
{
    NSString* reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    _senBeatCount = 0;
}

//收到服务器发来的数据
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
//    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithJsonString:message];
    dispatch_async(self.handlequeue, ^{
        NSDictionary *dic = [HandleTool dictionaryWithJsonString:message];
        SocketModel *model = [SocketModel mj_objectWithKeyValues:dic];
        SocketDataHandler *handler = [SocketDataHandler shareInstance];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self xw_postNotificationWithName:ProductAlwaysNotice userInfo:@{@"model":model}];
        });
        
        NSArray *marray = [NSArray arrayWithArray:handler.dataList];
        for (int i = 0;i < marray.count;i++) {
            
            SocketModel *smodel = marray[i];
                if ([smodel.symbol isEqualToString:model.symbol]) {
                    
                    [handler.dataList removeObjectAtIndex:i];
                    break;
                }
            }
            [handler.dataList addObject:model];
          
    });

    
}


@end
