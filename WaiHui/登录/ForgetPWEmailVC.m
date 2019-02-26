//
//  ForgetPWEmailVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ForgetPWEmailVC.h"
#import "ForgetPwEmailNextVC.h"
#import "ForgetPWPhoneVC.h"

@interface ForgetPWEmailVC ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@end

@implementation ForgetPWEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    self.emailLab.hidden = YES;

}
- (IBAction)dismissAC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)lookUpAC:(id)sender {
}

- (IBAction)doneAC:(id)sender {
    
    if (self.emailField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱！"];
        return;
    }
    
    if (![HandleTool isEmail:self.emailField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱！"];
        return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"17",@"keyword":self.emailField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            [self sendCodeWithEmail:self.emailField.text];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)sendCodeWithEmail:(NSString *)email
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"16",@"email":self.emailField.text,@"template":@"1"};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            
            ForgetPwEmailNextVC *vc = [ForgetPwEmailNextVC new];
            vc.emailStr = self.emailField.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}
- (IBAction)forgetPhoneAC:(id)sender {
    
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] isKindOfClass:[ForgetPWPhoneVC class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self.navigationController pushViewController:[ForgetPWPhoneVC new] animated:YES];
        
    }
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
