//
//  SucessAddMt4VC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/16.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "SucessAddMt4VC.h"

@interface SucessAddMt4VC ()
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation SucessAddMt4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lab1.text = self.mt4Id;
    self.lab2.text = self.pw;
    self.lab3.text = self.fwq;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
}
- (IBAction)doneAC:(id)sender {
    
    [self xw_postNotificationWithName:AccountMangerNotice userInfo:nil];
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
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
