//
//  SetVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "SetVC.h"

@interface SetVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *loginoutBtn;

@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    self.footerView.height = 160 + 44;
    self.dataList = @[@"清除缓存"];
    
    if ([LxUserDefaults boolForKey:IsLogin]) {
        self.tableView.tableFooterView = self.footerView;

    }
    
    self.loginoutBtn.hyb_borderWidth = 1;
    self.loginoutBtn.hyb_borderColor = [MyColor colorWithHexString:@"#EEEFF2"];
    [self.loginoutBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    
    
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, kScreenWidth, .5)];
        view.backgroundColor = [MyColor colorWithHexString:@"#F1F1F8"];
        [cell.contentView addSubview:view];
        
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [MyColor colorWithHexString:@"#4C5694"];
    
    cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#747898"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
//    cell.detailTextLabel.text = self.titles[indexPath.row];
    
    
    
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
    if (indexPath.row == 0) {
        SetVCAlert *alert = [[SetVCAlert alloc] initWithSetAlertWithTitle:@"清楚缓存" contentStr:@"是否清除所有缓存" btn1Str:@"取消" btn2Str:@"确定"];
        alert.clickBlock = ^(int index) {
            if (index == 1) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                });
            }
        };
        [alert show];
    }else if (indexPath.row == 1){
        //清楚缓存
        
    }else if (indexPath.row == 2){
        //版本更新
        
    }else{
        //退出账号
    }
        
}

- (IBAction)loginoutAC:(id)sender {
    
    
    SetVCAlert *alert = [[SetVCAlert alloc] initWithSetAlertWithTitle:@"退出账号" contentStr:@"您确定退出该账号？" btn1Str:@"取消" btn2Str:@"确定"];
    alert.clickBlock = ^(int index) {
        if (index == 1) {
            [LxUserDefaults setBool:NO forKey:IsLogin];
            [LxUserDefaults setObject:@"" forKey:Mt4_id];
            [LxUserDefaults synchronize];
            
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[LoginphoneVC new]];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:NO];
        }
    };
    [alert show];
    
    
   
    
   
}





@end
