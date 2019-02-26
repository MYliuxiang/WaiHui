//
//  ForgetPWPhoneVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ForgetPWPhoneVC.h"
#import "ForgetPwPhoneNextVC.h"
#import "ForgetPWEmailVC.h"

@interface ForgetPWPhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@end

@implementation ForgetPWPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    self.phoneLab.hidden = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];
    [self.phoneBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];

}
- (IBAction)forgetEmailAC:(id)sender {
    
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] isKindOfClass:[ForgetPWEmailVC class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self.navigationController pushViewController:[ForgetPWEmailVC new] animated:YES];
        
    }
    
}


- (IBAction)doneAC:(id)sender {
    
    if (self.phoneField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
            return;
    }
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"17",@"keyword":self.phoneField.text};
    [SVProgressHUD show];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            [self.view endEditing:YES];
            ForgetPwPhoneNextVC *vc = [ForgetPwPhoneNextVC new];
            vc.phoneStr = self.phoneField.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
    
   
}



- (IBAction)dismissAC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
