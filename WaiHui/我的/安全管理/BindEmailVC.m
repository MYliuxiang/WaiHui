//
//  BindEmailVC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/7.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "BindEmailVC.h"

@interface BindEmailVC ()
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property(nonatomic,strong) TXLimitedTextField *field1;
@property(nonatomic,strong) TXLimitedTextField *field2;
@property(nonatomic,strong) TXLimitedTextField *field3;
@property(nonatomic,strong) UIButton *codeBtn1;
@property(nonatomic,strong) UIButton *codeBtn2;



@end

@implementation BindEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"邮箱绑定";
    self.dataList = @[@"邮箱",@"验证码",@"手机号码",@"验证码"];
    self.footerView.height = 110 + 44 + 44;
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
    
    if (indexPath.row == 0) {
        static NSString *identifire = @"ResetCellID";
        ResetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ResetCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.titleLab.text = self.dataList[indexPath.row];
        cell.textField.placeholder = @"输入邮箱";
        cell.textFieldConstraint.constant = 135;
        self.field1 = cell.textField;
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 3){
        
        static NSString *identifire = @"cellIDCode";
        CodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CodeCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
        }
        cell.nameLab.text = self.dataList[indexPath.row];
        cell.textField.placeholder = @"输入验证码";
        if (indexPath.row == 1) {
            self.field2 = cell.textField;
//            self.field2.limitedNumber = 5;
            self.codeBtn1 = cell.codeBtn;
            [cell.codeBtn addTarget:self action:@selector(sendEmailCode) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else{
            self.field3 = cell.textField;
//            self.field3.limitedNumber = 5;
            self.codeBtn2 = cell.codeBtn;
            [cell.codeBtn addTarget:self action:@selector(sendPhoneCode) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
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
        cell.detailTextLabel.text = [self.phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];        return cell;
    }
    
}

- (void)sendPhoneCode
{
    
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
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeat1:) userInfo:nil repeats:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)repeat1:(NSTimer*)timer
{
    static int i = 1;
    int max = 60;
    if ((i%max)<max&&(i%max)!=0) {
        
        [self.codeBtn2 setTitle:[NSString stringWithFormat:@"（%.2ds）重新获取",(max-i%max)] forState:UIControlStateNormal];
        i++;
        self.codeBtn2.userInteractionEnabled = NO;
    }else{
        
        [timer invalidate];
        i++;
        [self.codeBtn2 setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.codeBtn2.userInteractionEnabled = YES;
    }
}

- (void)sendEmailCode
{
    if (self.field1.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱！"];
        return;
    }
    if (![HandleTool isEmail:self.field1.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱！"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"16",@"email":self.field1.text,@"template":@"3"};
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
        
        [self.codeBtn1 setTitle:[NSString stringWithFormat:@"（%.2ds）重新获取",(max-i%max)] forState:UIControlStateNormal];
        i++;
        self.codeBtn1.userInteractionEnabled = NO;
    }else{
        
        [timer invalidate];
        i++;
        [self.codeBtn1 setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.codeBtn1.userInteractionEnabled = YES;
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


- (IBAction)doneAC:(id)sender {
    
    if (self.field1.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱！"];
        return;
    }
    if (![HandleTool isEmail:self.field1.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱！"];
        return;
    }
    
    if (self.field2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱验证码！"];
        return;
    }
    
    if (self.field2.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"邮箱验证码输入错误！"];
        return;
    }
    
    if (self.field3.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机验证码！"];
        return;
    }
    
    if (self.field3.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"手机验证码输入错误！"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"18",@"Access_Token":[LxUserDefaults objectForKey:Token],@"phone":self.phoneStr,@"email":self.field1.text,@"verify":self.field3.text,@"email_code":self.field2.text,@"binding_type":@"2"};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [LxUserDefaults setObject:self.field1.text forKey:Email];
            [LxUserDefaults synchronize];
            if (self.reloadBlock) {
                self.reloadBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
