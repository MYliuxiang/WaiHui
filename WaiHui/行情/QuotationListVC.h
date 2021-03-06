//
//  QuotationListVC.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/6.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BaseViewController.h"
#import "QuoTationListCell.h"
#import "DetailQuotationVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuotationListVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,JXCategoryListContentViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,copy) NSString *biaoTi;

@end

NS_ASSUME_NONNULL_END
