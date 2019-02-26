//
//  RealOrBankVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/17.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "RealOrBankVC.h"

@interface RealOrBankVC ()
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation RealOrBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.successType == SuccessTypeReal) {
        self.title = @"实名认证";
        [self.doneBtn setTitle:@"开通账户" forState:UIControlStateNormal];
        
    }else{
        self.title = @"添加银行卡";
        
    }
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    
    [self wr_setNavBarShadowImageHidden:YES];
}
- (IBAction)backAC:(id)sender {
    
    if (self.successType == SuccessTypeReal) {
        
        [self gotoAccountVC];

        
        
    }else{
       
        [self.navigationController popToRootViewControllerAnimated:YES];

    }

}

- (void)gotoAccountVC
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"15",@"Access_Token":[LxUserDefaults objectForKey:Token]};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            NSArray *array = [Mt4Model mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
            AccountManagerVC *vc = [[AccountManagerVC alloc] init];
            vc.dataList = array;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
