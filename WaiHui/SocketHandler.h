//
//  SocketHandler.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/4.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    
    SocketConnectStatus_UnConnected,//未连接状态
    SocketConnectStatus_Connecting,//连接状态
    
    SocketConnectStatus_Connected,
    SocketConnectStatus_ReConnecting, //重新连接中
    SocketConnectStatus_Unknow //未知
    
}SocketConnectStatus;
NS_ASSUME_NONNULL_BEGIN

typedef void(^SocketConnectStatusBlock)(SocketConnectStatus status);

@protocol SocketHandlerDelegate <NSObject>

@required

//接收消息代理
//- (void)didReceiveMessage:(ChatModel *)chatModel type:(ChatMessageType)messageType;

@optional
//发送消息超时代理
- (void)sendMessageTimeOutWithTag:(long)tag;

@end

@interface SocketHandler : NSObject
@property (nonatomic, assign) SocketConnectStatus connectStatus;
@property (nonatomic, copy)   SocketConnectStatusBlock socketStausBlock;
@property (nonatomic, strong) SRWebSocket *webSocket;
+ (instancetype)shareInstance;//单例
- (void)connectServer;//建立长连接
- (void)SRWebSocketClose;//关闭长连接
- (void)sendDataToServer:(id)data;//发送数据给服务器
+ (void)startSocketStaus:(SocketConnectStatusBlock)socketStausBlock;

@end

NS_ASSUME_NONNULL_END
