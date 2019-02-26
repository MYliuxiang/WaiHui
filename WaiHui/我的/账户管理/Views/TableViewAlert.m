//
//  TableViewAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "TableViewAlert.h"

@implementation TableViewAlert

- (instancetype)initTableViewAlertWithTitle:(NSString *)title withDatasource:(NSArray *)datasource
{
    self = [super init];
    if (self) {
        
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        self.offsetBotom = 20;
        self.width = kScreenWidth - 26;
        self.titleLab.text = title;
        self.dataSource = datasource;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self setupAutoHeightWithBottomView:self.tableView bottomMargin:0];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    NSLog(@"%f,%f",self.height,self.height_sd);
//    [self hyb_addCornerRadius:5];
//    [self hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, self.height_sd)];
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    MySeletedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MySeletedCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.contentLab.text = self.dataSource[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
    [self disMiss];
    
}

@end
