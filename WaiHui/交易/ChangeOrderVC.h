//
//  ChangeOrderVC.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BaseViewController.h"
#import "ChangeCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangeOrderVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)ListModel *model;

@property (nonatomic,copy) void(^reloadBlock)(void) ;

@end

NS_ASSUME_NONNULL_END
