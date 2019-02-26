//
//  FillInInfoVC.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/10.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "BaseViewController.h"
#import "RegistSuccessVC.h"

typedef NS_ENUM(NSUInteger, RegistType)
{
    RegistTypePhone           = 0,
    RegistTypeEmail
};

NS_ASSUME_NONNULL_BEGIN

@interface FillInInfoVC : BaseViewController

@property(nonatomic,copy) NSString *registStr;
@property(nonatomic,assign) RegistType type;
@property(nonatomic,copy) NSString *reg_token;
@property(nonatomic,copy) NSString *agentnumber;
@property(nonatomic,copy) NSString *password;




@end

NS_ASSUME_NONNULL_END
