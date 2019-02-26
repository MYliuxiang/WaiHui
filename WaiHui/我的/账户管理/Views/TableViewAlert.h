//
//  TableViewAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"
#import "MySeletedCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewAlert : LxCustomAlert<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,copy) void(^clickBlock)(int index) ;


- (instancetype)initTableViewAlertWithTitle:(NSString *)title withDatasource:(NSArray *)datasource;

@end

NS_ASSUME_NONNULL_END
