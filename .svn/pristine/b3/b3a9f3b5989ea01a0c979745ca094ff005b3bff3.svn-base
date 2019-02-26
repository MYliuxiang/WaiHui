//
//  RealNameVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "RealNameVC.h"

@interface RealNameVC ()
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *nameField;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *idCardNumField;

@end

@implementation RealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"实名认证";
    [self wr_setNavBarShadowImageHidden:YES];
    [self.nextBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
}


- (IBAction)nextAC:(id)sender {
    
    if (self.nameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写名字！"];
        return;
    }
    
    if (self.idCardNumField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号码！"];
        return;
    }
    
    [self.view endEditing:YES];
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_MyCenter];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"2",@"Access_Token":[LxUserDefaults objectForKey:Token],@"realname":self.nameField.text,@"id_number":self.idCardNumField.text,@"verify_type":@"1"};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [SVProgressHUD dismiss];
            RealNameCardVC *vc = [RealNameCardVC new];
            vc.id_number = self.idCardNumField.text;
            vc.realname = self.nameField.text;
            [self.navigationController pushViewController:vc animated:YES];
            
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
