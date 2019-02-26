//
//  TermofvalidityAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"
#import "TermoCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TermofvalidityAlert : LxCustomAlert<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,copy) NSString *seletedStr;
@property (weak, nonatomic) IBOutlet UILabel *titlesLab;
@property (nonatomic,copy) void(^clickBlock)(NSString *indexStr) ;


- (instancetype)initTermofvalidityAlertWith:(NSString *)titles dataList:(NSArray *)dataList seletedStr:(NSString *)seletedStr;

@end

NS_ASSUME_NONNULL_END



