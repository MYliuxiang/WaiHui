//
//  CashInOrOutVC.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BaseViewController.h"
#import "CashInVC.h"
#import "CashOutVC.h"
#import "CashListVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashInOrOutVC : BaseViewController<JXCategoryListContainerViewDelegate>
@property(nonatomic,copy) NSString *mt4Str;

@end

NS_ASSUME_NONNULL_END
