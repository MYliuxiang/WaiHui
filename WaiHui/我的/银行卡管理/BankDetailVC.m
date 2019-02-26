//
//  BankDetailVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/17.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BankDetailVC.h"

@interface BankDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) NSArray *titles;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;



@end

@implementation BankDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"银行卡管理";
    self.dataList = @[@"银行卡号",@"银行名称",@"开户行网点",@"预留手机号码"];
    
   NSString *phonestr = [[LxUserDefaults objectForKey:Phone] stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
//    NSString *bankStr = [self.model.bank_number stringByReplacingCharactersInRange:NSMakeRange(3, self.model.bank_number.length - 8 - 1)  withString:@"*****"];
    NSString *bankStr = self.model.bank_number;


    self.titles = @[bankStr,self.model.bank_name,self.model.subbranch,phonestr];
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    
    self.footerView.height = 154 + 44 + 44;
    self.tableView.tableFooterView = self.footerView;
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kScreenWidth, .5)];
        view.backgroundColor = [MyColor colorWithHexString:@"#F1F1F8"];
        [cell.contentView addSubview:view];
        
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [MyColor colorWithHexString:@"#4C5694"];
    
    cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#747898"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = self.titles[indexPath.row];
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [MyColor colorWithHexString:@"#F7F9FE"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}


- (IBAction)doneAC:(id)sender {
    
    AddBankVC *vc = [AddBankVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}




@end
