//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Finish_Block) (id result);
typedef void(^Error_Block) (NSError *error);

typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_Post,
    RequestType_Get
};

typedef NS_ENUM(NSInteger, DataType) {
    DataType_Image,
    DataType_Mp3
};

@interface WXDataService : NSObject

@property (nonatomic,assign)BOOL isHUD;


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
                                errorBlock:(Error_Block)errorBlock;





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
                                   errorBlock:(Error_Block)errorBlock;


@end
