//
//  ResetPassWordVC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/7.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "ResetPassWordVC.h"

@interface ResetPassWordVC ()
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,strong) TXLimitedTextField *field1;
@property (nonatomic,strong) TXLimitedTextField *field2;
@property (nonatomic,strong) TXLimitedTextField *field3;
@property (nonatomic,strong) TXLimitedTextField *field4;
@property (nonatomic,strong) UIButton *codeBtn;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ResetPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改登录密码";
    self.dataList = @[@"原密码",@"新密码",@"确认新密码",@"手机号",@"验证码"];
    self.footerView.height = 110 + 44 + 44;
    self.tableView.tableFooterView = self.footerView;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    
}

- (IBAction)doneAC:(id)sender {
    
    if (self.field1.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入原密码！"];
        return;
    }
    
    if (self.field1.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"原密码输入错误！"];
        return;
    }
    
    if ([HandleTool checkIsHaveNumAndLetter:self.field1.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"原密码请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.field1.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"原密码不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.field1.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"原密码没有包含数字"];
        return;
    }
    
    if (self.field2.text == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码！"];
        return;
    }
    
    if (self.field2.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"新密码输入错误！"];
        return;
    }
    
    if ([HandleTool checkIsHaveNumAndLetter:self.field2.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"新密码请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.field2.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"新密码不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.field2.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"新密码没有包含数字"];
        return;
    }
    
    if(![self.field2.text isEqualToString:self.field3.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同！"];
        return;
        
    }
    
    if(self.field4.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
        return;
        
    }
    if(self.field4.text.length < 5){
        [SVProgressHUD showErrorWithStatus:@"验证码输入错误！"];
        return;
        
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"19",@"Access_Token":[LxUserDefaults objectForKey:Token],@"original_pass":self.field1.text,@"new_pass":self.field2.text,@"confirm_new_pass":self.field3.text,@"verify":self.field4.text};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
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
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
        static NSString *identifire = @"ResetCellID";
        ResetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ResetCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.titleLab.text = self.dataList[indexPath.row];
        if (indexPath.row == 0) {
            cell.textField.placeholder = @"输入旧密码";
            self.field1 = cell.textField;
            self.field1.limitedNumber = 24;

        }else if(indexPath.row == 1){
            cell.textField.placeholder = @"输入新密码";
            self.field2 = cell.textField;
            self.field2.limitedNumber = 24;
            
        }else{
            cell.textField.placeholder = @"再次输入新密码";
            self.field3 = cell.textField;
            self.field3.limitedNumber = 24;

        }
        cell.textFieldConstraint.constant = 135;
        
        return cell;
    }else if (indexPath.row == 4){
        
        static NSString *identifire = @"cellIDCode";
        CodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CodeCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.nameLab.text = self.dataList[indexPath.row];
        cell.textField.placeholder = @"输入验证码";
        self.field4 = cell.textField;
//        self.field4.limitedNumber = 5;
        self.codeBtn = cell.codeBtn;
        [cell.codeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
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
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#747898"];
        cell.detailTextLabel.text = [self.phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
        return cell;
    }
    
}

- (void)sendCode:(UIButton *)sender{
    
    if (self.phoneStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"phone":self.phoneStr};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeat:) userInfo:nil repeats:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}


- (void)repeat:(NSTimer*)timer
{
    static int i = 1;
    int max = 60;
    if ((i%max)<max&&(i%max)!=0) {
        
        [self.codeBtn setTitle:[NSString stringWithFormat:@"（%.2ds）重新获取",(max-i%max)] forState:UIControlStateNormal];
        i++;
        self.codeBtn.userInteractionEnabled = NO;
    }else{
        
        [timer invalidate];
        i++;
        [self.codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = YES;
    }
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


@end
