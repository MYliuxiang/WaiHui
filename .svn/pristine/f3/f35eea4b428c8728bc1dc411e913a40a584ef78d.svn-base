//
//  ForgetPwPhoneNextVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ForgetPwPhoneNextVC.h"

@interface ForgetPwPhoneNextVC ()
@property (weak, nonatomic) IBOutlet TXLimitedTextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;

@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwField;

@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation ForgetPwPhoneNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
//    self.codeField.limitedNumber = 5;
    self.codeLab.hidden = YES;
    self.pwLab.hidden = YES;

}

- (IBAction)dismissAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)doneAC:(id)sender {
    
    
    if (self.phoneStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        return;
    }
    
    if (self.codeField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写验证码！"];
        return;
    }
    
    if (self.pwField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码！"];
        return;
    }
    
    if (self.pwField.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"您输入的密码必须大于6位字符！"];
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
    entity.parameters = @{@"types":@"14",@"phone":self.phoneStr,@"password":self.pwField.text,@"verify":self.codeField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        [self.view endEditing:YES];

        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            
            [LxUserDefaults setObject:self.phoneStr forKey:Phone];
            [LxUserDefaults synchronize];
            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
}

- (IBAction)codeAC:(id)sender {
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


@end
