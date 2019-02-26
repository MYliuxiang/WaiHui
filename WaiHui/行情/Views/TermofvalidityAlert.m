//
//  TermofvalidityAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "TermofvalidityAlert.h"

@implementation TermofvalidityAlert

- (instancetype)initTermofvalidityAlertWith:(NSString *)titles dataList:(NSArray *)dataList seletedStr:(NSString *)seletedStr
{
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.tableView bottomMargin:0];
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        self.offsetBotom = 20;
        self.width = kScreenWidth - 26;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.titlesLab.text = titles;
        self.dataList = dataList;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.seletedStr = seletedStr;
        [self.tableView reloadData];
        
    }
    return self;
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    TermoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TermoCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.titleLab.text = self.dataList[indexPath.row];
    if ([cell.titleLab.text isEqualToString:self.seletedStr]) {
        cell.seImg.hidden = NO;
    }else{
        cell.seImg.hidden = YES;
    }
    
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
        self.clickBlock(self.dataList[indexPath.row]);
    }
    [self.tableView reloadData];
    [self disMiss];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
