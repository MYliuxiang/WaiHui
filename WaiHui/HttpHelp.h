//
//  HttpHelp.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/24.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 测试登录账号
 测试帐号：18580744910   密码:Qo123456
 帐号:13723706079 密码:Qo123456
 */



extern NSString *const IsLogin;

extern NSString *const Token;

extern NSString *const Mt4_id;


extern NSString *const Phone;
extern NSString *const Email;

extern NSString *const Id_Card_Status;
extern NSString *const Bank_status;




extern NSString *const MainUrl;
extern NSString *const Url_userAction;
extern NSString *const Url_MyCenter;
extern NSString *const Url_ImagePost;
extern NSString *const Url_marketCentre;
extern NSString *const Url_Mt4Info;


extern NSString *const Url_transactionAction;


extern NSString *const Web_url;
extern NSString *const BaseWeb_url;





//通知
extern NSString *const LoginCompletionNotice; //登录通知
extern NSString *const SocketNotice;
extern NSString *const SocketDataChanger; //定时器socket改变
extern NSString *const AccountMangerNotice; // 账号改变
extern NSString *const OptionalNotice; //自选通知


extern NSString *const HoldChangeNotice; // 持仓改变
extern NSString *const ListChangeNotice; // 挂单改变


extern NSString *const ProductAlwaysNotice; //socket 改变







NS_ASSUME_NONNULL_BEGIN

@interface HttpHelp : NSObject

@end

NS_ASSUME_NONNULL_END
