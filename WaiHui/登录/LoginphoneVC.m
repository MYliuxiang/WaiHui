//
//  LoginphoneVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LoginphoneVC.h"
#import "RegistPhoneVC.h"
#import "ForgetPWPhoneVC.h"
@interface LoginphoneVC ()
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *pwField;
@property (weak, nonatomic) IBOutlet UIButton *longinBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;

@end

@implementation LoginphoneVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([LxUserDefaults objectForKey:Phone] != nil) {
//        self.phoneField.text = [LxUserDefaults objectForKey:Phone];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    self.fd_prefersNavigationBarHidden = YES;
    [self.longinBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    [self.phoneBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.phoneLab.hidden = YES;
    self.pwLab.hidden = YES;
    self.pwField.limitedNumber = 20;

}

- (IBAction)emailLogin:(id)sender {
    
    LoginEmailVC *vc = [LoginEmailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)registAC:(id)sender {
    
    
    
    RegistPhoneVC *vc = [RegistPhoneVC new];
//    FillInInfoVC *vc = [FillInInfoVC new];

    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)forGetPwAC:(id)sender {
    
    ForgetPWPhoneVC *vc = [ForgetPWPhoneVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)longinAC:(id)sender {
    
    if (self.phoneField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
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
    entity.parameters = @{@"types":@"1",@"phone":self.phoneField.text,@"password":self.pwField.text};
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
            [LxUserDefaults setObject:result[@"data"][@"email"] forKey:Email];

            [LxUserDefaults setObject:self.phoneField.text forKey:Phone];
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

- (IBAction)dismissAC:(id)sender {
    
    if (self.backIndex == YES) {
        
        MainTabBarController *vc= [MainTabBarController shareMainTabBarController];
        vc.selectedIndex = 0;
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];

        
    }else{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }

}

@end
