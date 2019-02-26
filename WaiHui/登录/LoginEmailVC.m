//
//  LoginEmailVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LoginEmailVC.h"
#import "RegistEmailVC.h"
#import "ForgetPWEmailVC.h"

@interface LoginEmailVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginEmailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([LxUserDefaults objectForKey:Email] != nil) {
//        self.emailField.text = [LxUserDefaults objectForKey:Email];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  
    self.fd_prefersNavigationBarHidden = YES;
    [self.loginBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    self.pwField.limitedNumber = 24;
    self.phoneLab.hidden = YES;
    self.pwLab.hidden = YES;
    
    //    if ([LxUserDefaults objectForKey:Phone] != nil) {
    //        self.phoneField.text = [LxUserDefaults objectForKey:Phone];
    //    }

}
- (IBAction)dismisAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registAC:(id)sender {
    
    RegistEmailVC *vc = [RegistEmailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)forgetAC:(id)sender {
    
    ForgetPWEmailVC *vc = [ForgetPWEmailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)phoneLoginAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (IBAction)longinAC:(id)sender {
    
    if (self.emailField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱！"];
        return;
    }
    if (![HandleTool isEmail:self.emailField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱！"];
        return;
    }
    
    if (self.pwField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码！"];
        return;
    }
    
    if (self.pwField.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"密码输入错误！"];
        return;
    }
    /*
     返回0、1、2 3为格式不正确，返回4为密码格式正确
     0长度不正确
     1没有大写或小写
     2含有特殊字符
     3没有数字
     */
    if ([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入含有大小写的英文字母"];
        return;
    }
    if([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 2){
        [SVProgressHUD showErrorWithStatus:@"不能包含特殊字母"];
        return;
    }
    if ([HandleTool checkIsHaveNumAndLetter:self.pwField.text] == 3){
        [SVProgressHUD showErrorWithStatus:@"没有包含数字"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"1",@"phone":self.emailField.text,@"password":self.pwField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            [LxUserDefaults setBool:YES forKey:IsLogin];
            [LxUserDefaults setObject:result[@"data"][@"token"] forKey:Token];
            [LxUserDefaults setObject:result[@"data"][@"mt4_id"] forKey:Mt4_id];
            [LxUserDefaults setObject:self.emailField.text forKey:Email];
            [LxUserDefaults synchronize];
            
            //            [self.navigationController dismissViewControllerAnimated:YES completion:];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
                [self xw_postNotificationWithName:LoginCompletionNotice userInfo:nil];
            }];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
