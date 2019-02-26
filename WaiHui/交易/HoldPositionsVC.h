//
//  HoldPositionsVC.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/11.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BaseViewController.h"
#import "HoldCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HoldPositionsVC : BaseViewController<JXPagerViewListViewDelegate>

@property (nonatomic,copy) NSString *mt4Str;
@property (nonatomic,copy) void(^totalIncom)(double total) ;


@end

NS_ASSUME_NONNULL_END
