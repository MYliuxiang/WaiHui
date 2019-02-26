//
//  ResetPWStartVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ResetPWStartVC.h"

@interface ResetPWStartVC ()
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) TXLimitedTextView *onePwField;
@property (nonatomic,strong) TXLimitedTextView *twoField;
@property (nonatomic,strong) TXLimitedTextView *codeField;


@end

@implementation ResetPWStartVC
- (IBAction)doneAC:(id)sender {
    
    if (self.onePwField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入新密码！"];
        return;
    }
    
    if (self.onePwField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"新密码输入错误！"];
        return;
    }
    
    if ([HandleTool checkIsHaveNumAndLetter:self.onePwField.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"新密码请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.onePwField.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"新密码不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.onePwField.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"新密码没有包含数字"];
        return;
    }
    
    if (self.twoField.text == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入新密码！"];
        return;
    }
    
   
    
    if(![self.onePwField.text isEqualToString:self.twoField.text]){
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同！"];
        return;
        
    }
    
    if(self.codeField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
        return;
        
    }
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    //@"Access_Token":[LxUserDefaults objectForKey:Token]
    entity.parameters = @{@"types":@"13",@"mt4_id":self.mt4Str,@"password":self.onePwField.text,@"qrpassword":self.twoField.text,@"verify":self.codeField.text,@"phone":[LxUserDefaults objectForKey:Phone]};
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"重置密码";
    self.dataList = @[@"MT4账号",@"新密码",@"确认新密码",@"手机号",@"验证码"];
    self.footerView.height = 124;
    self.tableView.tableFooterView = self.footerView;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    
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
    if (indexPath.row ==4) {
        
        static NSString *identifire = @"cellIDstart";
        StartPwCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"StartPwCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        cell.nameLab.text = self.dataList[indexPath.row];
        cell.textField.placeholder = @"输入验证码";
        self.codeField = cell.textField;
        
        
        self.sendBtn = cell.sendBtn;
        [self.sendBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }else{
        
        static NSString *identifire = @"cellID";

        ResetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ResetCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textField.textAlignment = NSTextAlignmentRight;

        if (indexPath.row == 0) {
            cell.textField.text = self.mt4Str;
            cell.textField.placeholder = @"";
            cell.textField.userInteractionEnabled = NO;
            cell.textField.secureTextEntry = NO;

        }else if (indexPath.row == 1){
            cell.textField.text = @"";
            cell.textField.placeholder = @"输入新密码";
            cell.textField.userInteractionEnabled = YES;
            cell.textField.secureTextEntry = YES;
            self.onePwField = cell.textField;
            self.onePwField.limitedNumber = 16;
            

        }else if (indexPath.row == 2){
            cell.textField.text = @"";
            cell.textField.placeholder = @"再次输入新密码";
            cell.textField.userInteractionEnabled = YES;
            cell.textField.secureTextEntry = YES;
            self.twoField = cell.textField;
            self.twoField.limitedNumber = 16;
            
        }else{
            cell.textField.text = [LxUserDefaults objectForKey:Phone];
            cell.textField.placeholder = @"";
            cell.textField.userInteractionEnabled = NO;
            cell.textField.secureTextEntry = NO;

        }
        cell.titleLab.text = self.dataList[indexPath.row];
        return cell;
    }
    
}

- (void)sendCode:(UIButton *)sender{
    
   
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"phone":[LxUserDefaults objectForKey:Phone]};
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
        
        [self.sendBtn setTitle:[NSString stringWithFormat:@"（%.2ds）重新获取",(max-i%max)] forState:UIControlStateNormal];
        i++;
        self.sendBtn.userInteractionEnabled = NO;
    }else{
        
        [timer invalidate];
        i++;
        [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.sendBtn.userInteractionEnabled = YES;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [MyColor colorWithHexString:@"#F7F9FE"];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


@end
