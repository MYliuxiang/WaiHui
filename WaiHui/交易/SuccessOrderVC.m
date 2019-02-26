//
//  SuccessOrderVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "SuccessOrderVC.h"

@interface SuccessOrderVC ()
@property (weak, nonatomic) IBOutlet UIView *tishiView;
@property (weak, nonatomic) IBOutlet UILabel *tishiLab;
@property (weak, nonatomic) IBOutlet UILabel *tishiSubLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;

@end

@implementation SuccessOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.successType == SuccessTypeLoss) {
        self.title = @"设置止盈止损成功";
        self.tishiSubLab.hidden = YES;
        self.bottomDistance.constant = 0;

    }else{
        self.title = @"平仓成功";
        self.tishiSubLab.hidden = NO;
        self.bottomDistance.constant = 25;


    }
    
    
    [self wr_setNavBarShadowImageHidden:YES];

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
