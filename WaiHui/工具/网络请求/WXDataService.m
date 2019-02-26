//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "WXDataService.h"
#import "NSDictionary+SetNullWithStr.h"
/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO
/**
 *  SSL 证书名称，仅支持cer格式。
 */
#define certificate @"1234"

#define kTimeOutInterval 30 // 请求超时的时间

@implementation WXDataService

//网络监听
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}

#pragma mark - 创建请求者
+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL)
    {
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    
    return manager;
}


/**
 请求回调
 
 @param url 请求的url
 @param params 请求参数
 @param requestType 请求方式
 @param ishud 是否有hud
 @param finishBlock 请求成功的回调
 @param errorBlock 请求失败的回调
 @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager *)requestAFWithURL:(NSString *)url
                                    params:(NSDictionary *)params
                               requestType:(RequestType)requestType
                                     ishud:(BOOL)ishud
                               finishBlock:(Finish_Block)finishBlock
                                errorBlock:(Error_Block)errorBlock
{
    if (ishud) {
        
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
    }
    
    AFHTTPSessionManager *manager = [self manager];

  
    switch (requestType) {
            
        case RequestType_Get:
        {
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self request_success_finishBlock:finishBlock responseObject:responseObject ishud:ishud];
             
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
               [self request_failure_errorBlock:errorBlock error:error ishud:ishud];
                
            }];
        }
            break;
        
        case RequestType_Post:
        {
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
               [self request_success_finishBlock:finishBlock responseObject:responseObject ishud:ishud];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self request_failure_errorBlock:errorBlock error:error ishud:ishud];
          
            }];
            
        }

            break;
            
        default:
            break;
    }
    
    return manager;
}



/**
  上传图片/音频文件
 
 @param url 请求的url
 @param params 请求参数
 @param dataType 图片 还是 音频
 @param ishud 是否有hud
 @param fileData 图片/音频数据
 @param finishBlock 请求成功的回调
 @param errorBlock 请求失败的回调
 @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager *)requestDataWithURL:(NSString *)url
                                      params:(NSDictionary *)params
                                    dataType:(DataType)dataType
                                       ishud:(BOOL)ishud
                                    fileData:(NSData *)fileData
                                 finishBlock:(Finish_Block)finishBlock
                                  errorBlock:(Error_Block)errorBlock;
{
    
    if (ishud) {
        
        [MBProgressHUD showMessag:@"正在上传,请稍后..." toView:[UIApplication sharedApplication].keyWindow];
        
    }
    
    AFHTTPSessionManager *manager = [self manager];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        switch (dataType) {
                
            case DataType_Mp3:
            {
                [formData appendPartWithFileData:fileData name:@"recoder" fileName:@"recoder.mp3" mimeType:@"mp3"];
            }
                break;
            case DataType_Image:
            {
                [formData appendPartWithFileData:fileData name:@"filename" fileName:@"my.png" mimeType:@"image/jpeg"];
            }
                break;
                
            default:
                break;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self request_success_finishBlock:finishBlock responseObject:responseObject ishud:ishud];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self request_failure_errorBlock:errorBlock error:error ishud:ishud];
        
    }];
    
    return manager;
    
}

/**
 上传多张图片
 
 @param url 请求的url
 @param params 请求参数
 @param ishud 是否有hud
 @param imageArry 图片数组
 @param finishBlock 请求成功的回调
 @param errorBlock 请求失败的回调
 @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager *)requestImagesWithURL:(NSString *)url
                                        params:(NSDictionary *)params
                                         ishud:(BOOL)ishud
                                     imageArry:(NSArray *)imageArry
                                   finishBlock:(Finish_Block)finishBlock
                                    errorBlock:(Error_Block)errorBlock
{
    
    if (ishud) {
        [MBProgressHUD showMessag:@"正在上传,请稍后..." toView:[UIApplication sharedApplication].keyWindow];

    }
    
    AFHTTPSessionManager *manager = [self manager];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(int i=0;i<imageArry.count;i++){
            
            if ([imageArry[i] isKindOfClass:[UIImage class]]) {
                UIImage  * img=imageArry[i];
                
                NSData  * feedbackImg =UIImageJPEGRepresentation(img, 0.5);
                //                NSData  * feedbackImg =UIImageJPEGRepresentation(img, 0.5);
                [formData appendPartWithFileData:feedbackImg name:@"photo" fileName:@"photo" mimeType:@"image/jpeg"];
                
            }else if([imageArry[i] isKindOfClass:[NSData class]]){
                
                NSData *videoData = [imageArry objectAtIndex:i];
                [formData appendPartWithFileData:videoData name:@"file" fileName:@"video1.mov" mimeType:@"video/quicktime"];
            }
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self request_success_finishBlock:finishBlock responseObject:responseObject ishud:ishud];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       [self request_failure_errorBlock:errorBlock error:error ishud:ishud];
        
    }];
    
    return manager;
    
    
}


/**
 请求成功的处理

 @param finishBlock 成功回调
 @param responseObject 回调数据
 @param ishud 是否有hud
 */
+ (void)request_success_finishBlock:(Finish_Block)finishBlock
                     responseObject:(id)responseObject
                              ishud:(BOOL)ishud

{
    if (ishud) {
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    if (finishBlock != nil) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finishBlock([NSDictionary changeType:result]);
    }
    
}

/**
 请求失败的处理
 
 @param errorBlock 失败回调
 @param error 失败数据
 @param ishud 是否有hud
 */
+ (void)request_failure_errorBlock:(Error_Block)errorBlock
                             error:(NSError *)error
                             ishud:(BOOL)ishud

{
    if (ishud) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    if (errorBlock != nil) {
        
        NSLog(@"Error: %@", [error localizedDescription]);
        
        errorBlock(error);
    }
    
}


+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}




@end
